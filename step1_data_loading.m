function [T, documents, labels] = step1_data_loading()
% Veri setini yükler, gereksiz sütunları kaldırır ve eksik verileri temizler.

    % Dosya adı ve yükleme
    fileName = 'Combined Data.csv';
    T = readtable(fileName, 'TextType', 'string');

    % Gereksiz 'Unnamed: 0' sütununu kaldırma
    if size(T, 2) > 2 
        T(:, 1) = [];
    end

    % Sütun adlarını ayarlama
    T.Properties.VariableNames = {'Text', 'Label'};

    % Eksik (NaN) içeren satırları kaldırma (özellikle 'statement' sütununda)
    T = rmmissing(T);

    % Metin ve Etiketleri ayrı değişkenlere atama
    documents = T.Text;
    labels = T.Label;
    
    fprintf('   -> Başlangıç: %d satır. Temizlik Sonrası: %d satır.\n', height(readtable(fileName)), height(T));
    
end