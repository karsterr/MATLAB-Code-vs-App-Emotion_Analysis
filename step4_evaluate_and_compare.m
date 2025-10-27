function [hamKodMetrics] = step4_evaluate_and_compare(Mdl, testLabels, XTest, modelName)
% Modelin test seti üzerindeki performansını değerlendirir ve sonuçları kaydeder.

    % 1. Test Verisi Üzerinde Tahmin Yapma
    YPredicted = predict(Mdl, XTest);

    % 2. Değerlendirme Metriklerini Hesaplama
    % Doğruluk (Accuracy)
    Accuracy = sum(YPredicted == testLabels) / numel(testLabels);

    % Karmaşıklık Matrisi (Confusion Matrix)
    C = confusionmat(testLabels, YPredicted);
    
    % Precision, Recall ve F1 Skoru (Ortalama olarak hesaplanabilir)
    
    % Performans metriklerini bir struct içinde toplama
    hamKodMetrics.Model = modelName;
    hamKodMetrics.Accuracy = Accuracy;
    hamKodMetrics.ConfusionMatrix = C;
    hamKodMetrics.Classes = categories(testLabels);
    
    % 3. Sonuçları MATLAB Çalışma Alanına ve Bir Dosyaya Kaydetme
    assignin('base', 'HamKodSonuclari', hamKodMetrics); 
    save('hamKod_analysis_results.mat', 'hamKodMetrics');

    fprintf('   -> Test Seti Doğruluğu: %.2f%%\n', hamKodMetrics.Accuracy * 100);
    fprintf('   -> Sonuçlar "HamKodSonuclari" değişkenine ve hamKod_analysis_results.mat dosyasına kaydedildi.\n');
    
    % 4. Karmaşıklık Matrisini Görselleştirme (İsteğe bağlı)
    % confusionchart(testLabels, YPredicted);
    % title(sprintf('Ham Kod - %s Karmaşıklık Matrisi', modelName));
    
end