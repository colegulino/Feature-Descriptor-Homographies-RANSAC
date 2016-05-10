function [  ] = showIP(im, locsDoG )
figure;
imagesc(uint8(rgb2gray(im)));
colormap gray;
hold on;
scatter(locsDoG(1:131,1,1), locsDoG(1:131,2,1), 'g');
hold off;

end

