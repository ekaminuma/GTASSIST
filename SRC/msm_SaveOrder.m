function msm_SaveOrder()
%
% GTAssist - MSM
% by eli@gsc.riken.jp
% 
% (c) 2006 RIKEN GSC
%
%----- get fileinfo------------------------------
[filename, pathname,filterindex] = uiputfile( ...
 {'*.txt';'*.*'}, ...
 'Save order in a text file');
%----- check cancel------------------------------
if filename==0
    return
end    
%----- get order----------------------------------

flist=getappdata(0,'filelist');
mom_sort=getappdata(0,'mom_sort');
dat=cell(1,1);
for nn=1:size(flist,1)
    dat{nn,1}=sprintf('%d',nn);
    [tp,tmpname,te,tv]=fileparts(flist{nn,1});
    dat{nn,2}=tmpname;
    dat{nn,3}=flist{nn,1};
    dat{nn,4}=mom_sort(nn);
end    
%------- save data -------------------------------------

outname=sprintf('%s/%s',pathname,filename);
flag=saveOrderData(outname,dat);
if flag==0
    uiwait(warndlg('Could not save the order.','Warning'));
end    
return

%-------------------------------------------------------
function [flag]=saveOrderData(outname,dat)
flag=1;
fid=fopen(outname,'w');
if fid==-1
    flag=0;
    return
end
for nn=1:size(dat,1)
fprintf(fid,'%s\t%s\t%s\t%f\n',dat{nn,1},dat{nn,2},dat{nn,3},dat{nn,4});    
end
fclose(fid);
return
%-------------------------------------------------------