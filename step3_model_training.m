function [Mdl, testLabels, XTest, cvAccuracy] = step3_model_training(X, Y)
% NİHAİ ÇÖZÜM: ADİL KARŞILAŞTIRMA (%100 VERİ) + ZAMAN ÖLÇÜMÜ
% KULLANICI İSTEĞİ: Eğitim süresini ölçmek için 'tic' ve 'toc' eklendi.
% Model, 'fitctree' (Karar Ağacı)
% Veri, TAMAMI (52.681 satır)

    fprintf('   -> Model Stratejisi: Karar Ağacı (fitctree)\n');
    fprintf('   -> ADİL KARŞILAŞTIRMA: Tam veri seti (%d satır) kullanılıyor.\n', size(X, 1));
    fprintf('   -> UYARI: Eğitim 5-15 dakika sürebilir. Lütfen sabırla bekleyin...\n');

    X = double(X); 

    % 1. Veri Bölme (TAM Veri Seti Üzerinde)
    rng(42); 
    cv = cvpartition(Y, 'Holdout', 0.2); 
    
    XTrain = X(training(cv), :);
    YTrain = Y(training(cv));
    XTest = X(test(cv), :);
    testLabels = Y(test(cv));
    
    fprintf('   -> Eğitim Seti Boyutu: %d, Test Seti Boyutu: %d\n', size(XTrain, 1), size(XTest, 1));

    % 2. Model Eğitimi (Zaman Ölçümlü)
    fprintf('   -> [Eğitim 1/2] Ana Model Eğitiliyor (Karar Ağacı)...\n');
    
    tic; % <-- ZAMANLAYICI BAŞLAT (ANA MODEL)
    Mdl = fitctree(XTrain, YTrain);
    elapsedTimeModel = toc; % <-- ZAMANLAYICI DURDUR VE SÜREYİ KAYDET
    
    fprintf('   -> Model: Karar Ağacı (fitctree) ile eğitildi.\n');
    fprintf('   -> *** Ana Model Eğitim Süresi: %.2f saniye ***\n', elapsedTimeModel);


    % 3. Çapraz Doğrulama (Zaman Ölçümlü)
    fprintf('\n   -> [Eğitim 2/2] 5-Katlı Çapraz Doğrulama Başlatılıyor...\n');
    
    tic; % <-- ZAMANLAYICI BAŞLAT (ÇAPRAZ DOĞRULAMA)
    cvMdl = crossval(Mdl, 'KFold', 5); 
    elapsedTimeCV = toc; % <-- ZAMANLAYICI DURDUR VE SÜREYİ KAYDET
    
    fprintf('   -> 5-Katlı Çapraz Doğrulama Tamamlandı.\n');
    fprintf('   -> *** Çapraz Doğrulama Süresi: %.2f saniye ***\n', elapsedTimeCV);
    
    cvAccuracy = 1 - kfoldLoss(cvMdl);
    
end