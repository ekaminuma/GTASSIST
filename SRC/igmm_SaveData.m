function igmm_SaveData(handles)
%
% GTAssist - IGMM 
% by eli@gsc.riken.jp
% 
% (c) 2006 RIKEN GSC
%
%----- get fileinfo------------------------------
[filename, pathname,filterindex] = uiputfile( ...
 {'*.txt';'*.*'}, ...
 'Save data in the tab-separated text file');
%----- check cancel------------------------------
if filename==0
    return
end    
%----- save data----------------------------------

x=get(handles.axes1,'UserData');

outname=sprintf('%s/%s',pathname,filename);

saveData(outname,x);
if exist(outname)==0
    uiwait(warndlg('Could not save the data.','Warning'));
end   

%------ update ---------------------------------
igmm_SetSelectMessage(handles,'');
igmm_MarkHighlight(handles,[],[]);
igmm_ClearStatus(handles,1);

return
%------------------------------------------------
function saveData(outname,x)

fheader=getHeaderStr(outname);
tmp=getappdata(0,'indivnames');
if size(tmp,1)~=size(x,1)
    return
end

x=mergeData(x);
[RN,CN]=size(x);

fid=fopen(outname,'w');
if fid==-1
   return 
end    
fprintf(fid,'%s',fheader);
for rr=1:RN
    fprintf(fid,'%s\t%f\t%f\t%d',char(tmp{rr,:}),x(rr,1),x(rr,2),x(rr,3));
    if CN>3
        for mm=1:CN-3
            xval=x(rr,mm+3);
            if isempty(xval) 
                fprintf(fid,'\t');
            else
                fprintf(fid,'\t%d',x(rr,mm+3));
            end    
        end
    end    
    fprintf(fid,'\n');
end    
fclose(fid);

return
%---------------------------------------
function xout=mergeData(xin)

xout=xin;
if size(xin,2)>3
    if sum(find(isnan(xin(:,3)))-find(isnan(xin(:,4))))~=0
        return
    end
    if nansum(xin(:,4)-xin(:,3))==0
        xout(:,3)=[];
    end    
end

return
%---------------------------------------
function out=getHeaderStr(outname)

[tp,tn,te] = fileparts(outname); 

str0=' ';
str1='%%%';
str2='COL1: unique individual name';
str3='COL2: fluorescent value of dye 1';
str4='COL3: fluorescent value of dye 2';
str5='COL4: classification code [-1:unknown; 0:NTC; 1:homo1; 2:homo2; 3:hetero]'; 
out=sprintf('%s\n%s%s%s%s\n%s\n%s%s%s\n%s%s%s\n%s%s%s\n%s%s%s\n%s\n', ...
                        str1, ...
                        str1,str0,tn,te,...
                        str1, ...
                        str1,str0,str2, ...
                        str1,str0,str3, ...
                        str1,str0,str4, ...
                        str1,str0,str5, ...
                        str1);

return


