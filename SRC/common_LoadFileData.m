function [x,tmpname]=common_LoadFileData(handles,filename)
%
% GTAssist - MSM, IGMM 
% by eli@gsc.riken.jp
% 
% (c) 2006 RIKEN GSC
%

       x=[];
       tmpname=[];
       flag_err=0;
       if exist(filename)==0    
            flag_err=1;
            fprintf('[%s]]]\n',filename);
            msg='File not found';
       else    
            [tmppath,tmpname,tmpext,tmpver] = fileparts(filename);
            if strcmp(tmpext,'csv')==1
                tmpdlm=','; 
            else 
                tmpdlm='\t';
            end    
            [x,flag_err,msg]=getFileData(filename,tmpdlm);
           
       end
       
       if flag_err==1
            uiwait(errordlg(msg,'File Error'));
            delete(handles.figure1);
       end
      
return
%-------------------------------------------
function [x,flag_err,msg]=getFileData(filename,tmpdlm)

%--------------------------------
x=[];
flag_err=0;
msg=[];
setappdata(0,'fileheader',[]);
setappdata(0,'indivnames',[]);

%--------------------------------
fp=fopen(filename,'r');
if fp==-1, flag_err=1; msg='Cannot open file'; return, end    
while 1
      tline = fgetl(fp);
      if ~isstr(tline), break, end
      x=process_line(tline,x);
end
fclose(fp);
%---------------------------------

fhead=getappdata(0,'fileheader');
iname=getappdata(0,'indivnames');

%----------------------------------
if size(x,2)<3
       flag_err=1;
       msg=sprintf('Col# of %s',tmpname);
end    
            
return
%--------------------------------------------------
function x=process_line(tline,x)


%----- process comment lines -------------- 
if strncmp(tline,'%',1)==1
    tmp=getappdata(0,'fileheader');
    if isempty(tmp)
        fheader=sprintf('%s\n',tline);
    else
        fheader=sprintf('%s%s\n',tmp,tline);
    end    
    setappdata(0,'fileheader',fheader);
    return
end

%----------tokenize--------------------------
[tok,rem]=strtok(tline);
dat=[];
while 1
    [tmp,rem]=strtok(rem);
    if isempty(dat)
       dat=str2double(tmp); 
    else
       dat=[dat str2double(tmp)]; 
    end    
    if isempty(rem), break, end 
end

if isempty(x)
    x=dat;
else
    x=[x;dat]; 
end    
%--------save individual name-------------------
indivname=getappdata(0,'indivnames');
if isempty(indivname)
    indivname=cell(1,1);
    indivname{1,1}=tok;
else
    indivname{size(indivname,1)+1,1}=tok;
end    
setappdata(0,'indivnames',indivname);

return



