function [X, Y, modelName] = step2_text_preprocessing(documents, labels)
% Metin ön işleme yapar, TF-IDF matrisini oluşturur ve sayısal etiketleri hazırlar.

    % 1. Metin Ön İşleme (En Temel ve Kararlı Adımlar)
    cleanDocuments = tokenizedDocument(documents);
    
    % Noktalama işaretlerini kaldırma
    cleanDocuments = erasePunctuation(cleanDocuments);
    
    % Durak kelimeleri kaldırma (En güvenilir yöntem)
    try
        cleanDocuments = removeStopWords(cleanDocuments);
        fprintf('   -> Durak kelimeler (stopwords) başarılı bir şekilde kaldırıldı.\n');
    catch
        fprintf('   -> Uyumluluk sorunu nedeniyle durak kelime kaldırma adımı atlandı.\n');
    end

    % 1 veya 2 karakterli kısa kelimeleri kaldırma
    cleanDocuments = removeShortWords(cleanDocuments, 2); 
    
    % Kelimeleri küçük harfe dönüştürme (Normalize etme)
    cleanDocuments = normalizeWords(cleanDocuments);
    
    % Kök bulma (Stemming) fonksiyonu kullanılmıyor (Unrecognized function hatası nedeniyle)
    % cleanDocuments = stemDocuments(cleanDocuments); 

    % 2. Özellik Çıkarma (TF-IDF)
    bag = bagOfWords(cleanDocuments);
    
    % Belge sıklığı eşiği belirleme: Çok nadir (1 kez geçen) kelimeleri çıkar.
    bag = removeInfrequentWords(bag, 2); 
    
    % Sözlük kelimelerini kaldırma adımı, uyumluluk riski nedeniyle atlandı.
    % try
    %     bag = removeDictionaryWords(bag, 'Language', 'english');
    % catch
    % end

    % TF-IDF matrisini oluşturma
    tfIdfMatrix = tfidf(bag);
    
    % Seyrek (Sparse) matrisi yoğun (Dense) matrise dönüştürme (model eğitimi için)
    X = full(tfIdfMatrix); 

    % 3. Etiketleri Kategorik Hale Getirme
    Y = categorical(labels);

    modelName = 'Support Vector Machine (SVM)';
    
    fprintf('   -> Oluşturulan TF-IDF Özellik Sayısı (Sütun): %d\n', size(X, 2));
    
end