function msm_EstimatePdfs(handles,flag)
%
% GTAssist - MSM
% by eli@gsc.riken.jp
% 
% (c) 2006 RIKEN GSC
%
if strcmp(flag,'ideal')
    idname=getappdata(0,'id_filename');
    [tp,snpname,te,tv] = fileparts(idname);
    x=get(handles.axes1,'UserData');
    est_gauss_kernel2D(handles,handles.axes2,x,snpname,0);
else % test
    list_entries = get(handles.listbox1,'String');
    index_selected = get(handles.listbox1,'Value');  
    flist=getappdata(0,'filelist');%filename list
    FN=size(flist,1);
    for nn=1:FN
            if ~iscell(flist)
                filename=flist;
            else    
                filename=flist{nn,1};
            end    
            [x,snpname]=common_LoadFileData(handles,filename);
      
            x=common_NormalizeData(x);
            
            if nn==index_selected
                tmpaxes=handles.axes4;
            else
                tmpaxes=[];
            end    
            est_gauss_kernel2D(handles,tmpaxes,x,snpname,nn);
    end%for-nn    
    set(handles.listbox1,'Value',index_selected);
    
end%if
msm_CheckButtonOrder(handles);

return
%------------------------------------------------------------
function  est_gauss_kernel2D(handles,tmpaxes,idat,snpname,index)

       pN=size(idat,1);

        step=0.02;%spatial resolution
        xout=-0.2+step:step:1.2;%[-0.2 1.2]
        oN=length(xout);
        
        [mhat,shat1] = normfit(idat(:,1)) ;
        [mhat,shat2] = normfit(idat(:,2)) ;
        if shat1<shat2
                shat=shat1;
            else
                shat=shat2;
        end    
        h0=1.06*shat*pN^(-1/5);
        kall=zeros(oN,oN);
        
        %---set listbox--------------------------------
         if index>0
            set(handles.listbox1,'Value',index);
            drawnow;
         end
        %---main process --------------
    
        for pp=1:pN
              x0=idat(pp,1);
              y0=idat(pp,2);
              
              for qq=1:oN
                    ktmp=1/(2*pi*h0^2*pN)*exp(-(xout-x0).^2/(2*h0^2))*exp(-(xout(qq)-y0).^2/(2*h0^2))  ;
                    kall(qq,:)=kall(qq,:)+ktmp;          
              end     
              
        end
        %-----normalize------------------------
         zz=kall;
         zz=zz/sum(sum(zz));
        %-----save data--------------
        
        idx=xout;
        omatname=sprintf('tmp_%d.mat',index);
        save(omatname,'zz','idx');
    
        %-----plot figure-----------------
        if ~isempty(tmpaxes)
            msm_PlotPdfs(tmpaxes,idat,xout,kall,snpname);
        end
return
