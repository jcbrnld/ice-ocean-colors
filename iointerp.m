function newCmap = iointerp(cmap, nlevels,  highendcolor, lowendcolor)
% interpolation of ice/ocean color maps
% Jacob Arnold
% 22-Feb-2022
%
% Updated 31-May-2023
%
% Purpose: create n descrete color bins of an input colormap for
% non-continuous colormapping. 
%
% This also allows specification of additional color(s) at the high and/or
% low end of the color range. Custom colors must be specified by an RGB
% triplet of values between 0 and 1. (e.g. [0.9,0.4,0.4] orange-red or
% [0.5,0.9,0.8] turquoise)
% NOTE if additional colors are specified, they REPLACE their respective
% bins. So if you specify nlevels=10 and a highendcolor and lowendcolor,
% the colormap will be interpolated to 8 bins (bins 2-9) and the new high and low end
% colors will be added on the end bins (1 and 10)
% ~~~~~~~~~~~~~~~~~~~~
% examples
% 1. create colormap from iocolor with 8 bins
%       cmap = colormap(iointerp(iocolor('sit'), 8));
%
% 2. create colormap with 8 bins and a custom top end color
%       cmap = colormap(iointerp(iocolor('sit3'), 8, [0.9,0.4,0.4]));
%
% 3. create colormap with 8 bins and a custom bottom end color
%       cmap = colormap(iointerp(iocolor('space'), 8, [], [0.5,0.9,0.8]));
%
% 4. create colormap with 8 bins and custom top and bottom colors 
%       cmap = colormap(iointerp(iocolor('extrapolate'), 8, [0.2,0.8,0.7], [0.9,0.1,0.8]));
% ~~~~~~~~~~~~~~~~~~~~



if nargin ==3
    nlevels = nlevels-1;
elseif nargin ==4 
    if isempty(highendcolor)
        nlevels = nlevels-1;
    else
        nlevels = nlevels-2;
    end
end

for ii = 1:3
    X = 1:size(cmap,1);
    V = cmap(:,ii);
 
    Xq = linspace(1,size(cmap,1),nlevels); % Equal spacing

    newCmap(:,ii) = interp1(X, V, Xq, 'linear');
    clear X V Xq
    
end

if nargin == 4
    numcolsadd = length(lowendcolor(:,1));
    if length(lowendcolor(:,1))==1
        
        newCmap = [1,1,1;newCmap];
        newCmap(1,:) = lowendcolor;
        
    elseif length(lowendcolor(:,1))==2
        
        newCmap = [1,1,1;1,1,1;newCmap];
        newCmap(1:2,:) = lowendcolor;
    end
    
end

if nargin == 3 | nargin == 4
    if ~isempty(highendcolor)
        newCmap(end+1,:) = highendcolor;
    end
end


end


