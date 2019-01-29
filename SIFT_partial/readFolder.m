function [img_arr]=readFolder(filename)
%% parse path
%% Path to the folder with input images.
if ~isfolder(filename)
    errorMessage = sprintf('Error: The following folder does not exist:\n%s', filename);
    uiwait(warndlg(errorMessage));
    return;
end
filePattern = fullfile(filename, '*.JPG');
jpegFiles = dir(filePattern);
img_arr = cell(1,length(jpegFiles));
for k = 1:length(jpegFiles)
    baseFileName = jpegFiles(k).name;
    fullFileName = fullfile(filename, baseFileName);
    img_arr{k} = imread(fullFileName);
end

end