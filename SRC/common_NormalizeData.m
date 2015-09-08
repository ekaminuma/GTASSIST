function x=common_NormalizeData(x)
%
% GTAssist - MSM, IGMM 
% by eli@gsc.riken.jp
% 
% (c) 2006 RIKEN GSC
%
%-------------------------------
list=[];
list=find(x(:,3)==0); % search NTCs

%---set origin-------------------
if ~isempty(list)
    ntc=mean(x(list,1:2));
    x(:,1)=x(:,1)-ntc(1);
    x(:,2)=x(:,2)-ntc(2);
end
%---skip NaN labels--------------
y=x;
y(find(isnan(x(:,3))),:)=[];
%---normalize---------------------
xmax=max(max(y(:,1:2)));
x(:,1:2)=x(:,1:2)/xmax;

return
