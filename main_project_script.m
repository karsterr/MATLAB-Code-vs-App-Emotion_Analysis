%% MATLAB Projesi: Sosyal Medya Duygu Analizi - Ana Çalıştırıcı Script
% Bu script, projenin tüm ham kod aşamalarını sırasıyla çalıştırır.

% *************************************************************************
% ÖNEMLİ NOT:
% 1. 'Combined Data.csv' dosyasının bu script ile aynı klasörde olduğundan emin olun.
% 2. MATLAB'da Text Analytics Toolbox ve Statistics and Machine Learning Toolbox yüklü olmalıdır.
% *************************************************************************

clear; clc;
fprintf('--- MATLAB Projesi Başlatıldı ---\n');

%% AŞAMA 1: Veri Yükleme ve Başlangıç Temizliği
fprintf('\n[AŞAMA 1/4] Veri Yükleniyor ve İlk Temizlik Yapılıyor...\n');
[T, documents, labels] = step1_data_loading();
fprintf('Aşama 1 Tamamlandı.\n');

%% AŞAMA 2: Metin Ön İşleme ve Özellik Çıkarımı (TF-IDF)
fprintf('\n[AŞAMA 2/4] Metin Ön İşleme ve Özellik Çıkarımı (TF-IDF) Yapılıyor...\n');
[X, Y, modelName] = step2_text_preprocessing(documents, labels);
fprintf('Aşama 2 Tamamlandı. Özellik Matrisi X ve Etiketler Y Hazır.\n');

% <<< YENİ GÜNCELLEME BAŞLANGICI >>>
% X ve Y değişkenlerini diske kaydediyoruz.
% Bu sayede, bir dahaki sefere Classification Learner için tüm script'i
% yeniden çalıştırmak zorunda kalmayacaksınız.
fprintf('   -> X ve Y değişkenleri diske kaydediliyor (classification_data.mat)...\n');
% -v7.3 bayrağı, X matrisi çok büyük (2GB+) olabileceği için gereklidir.
try
    save('classification_data.mat', 'X', 'Y', '-v7.3');
    fprintf('   -> Kaydetme tamamlandı. (classification_data.mat)\n');
catch ME
    fprintf('   -> HATA: Dosya kaydedilemedi. Hata: %s\n', ME.message);
end
% <<< YENİ GÜNCELLEME SONU >>>


%% AŞAMA 3: Ham Kod ile Model Eğitimi (TAM VERİ SETİ %100)
% (Bu, son kullandığımız NİHAİ-TAM VERİ KODU (%100) olmalıdır)
fprintf('\n[AŞAMA 3/4] Ham Kod ile Sınıflandırma Modeli Eğitiliyor (Karar Ağacı)...\n');
[Mdl, testLabels, XTest, cvAccuracy] = step3_model_training(X, Y);
fprintf('Aşama 3 Tamamlandı. Çapraz Doğrulama Başarımı (Cross-Val Accuracy): %.2f%%\n', cvAccuracy * 100);

%% AŞAMA 4: Değerlendirme ve Sonuçların Kaydedilmesi
fprintf('\n[AŞAMA 4/4] Model Değerlendiriliyor ve Sonuçlar Kaydediliyor...\n');
[hamKodMetrics] = step4_evaluate_and_compare(Mdl, testLabels, XTest, modelName);
fprintf('Aşama 4 Tamamlandı. Tüm Ham Kod Analiz Metrikleri Kaydedildi.\n');

fprintf('\n--- PROJE HAM KOD AŞAMASI BAŞARIYLA TAMAMLANDI ---\n');
fprintf('Model Doğruluğu (Test Seti): %.2f%%\n', hamKodMetrics.Accuracy * 100);

%% SONRAKİ ADIM: Classification Learner Apps Karşılaştırması
fprintf('\nProje dosyaları (X ve Y) "classification_data.mat" olarak kaydedildi.\n');
fprintf('MATLAB''ı yeniden başlatsanız bile, Apps''i kullanmak için:\n');
fprintf('1. Önce komut penceresine: load(''classification_data.mat''); yazın.\n');
fprintf('2. Sonra komut penceresine: classificationLearner; yazın.\n');