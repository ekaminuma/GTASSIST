function msm_PlotData(handles,index)
%
% GTAssist - MSM
% by eli@gsc.riken.jp
% 
% (c) 2006 RIKEN GSC
%
    if index==0 %ideal data        
        filename=getappdata(0,'id_filename');
        tmpaxes1=handles.axes1;
        tmpaxes2=handles.axes2;
    else
        flist=getappdata(0,'filelist');    
        filename=flist{index,1};
        tmpaxes1=handles.axes3;
        tmpaxes2=handles.axes4;
    end 
    
    %----- for raw data-----------
    [x,snpname]=common_LoadFileData(handles,filename);
    x=common_NormalizeData(x);
    plotRawData(tmpaxes1,x,snpname);

    %----- for pdf data-----------
    if ~isempty(get(tmpaxes2,'Children'))
        matname=sprintf('tmp_%d.mat',index);
        d=load(matname);
        idx=d.idx;
        zz=d.zz;
        msm_PlotPdfs(tmpaxes2,x,idx,zz,snpname);
    end
    
    
return
%------------------------------------------------
function plotRawData(tmpaxes,x,snpname)

    axes(tmpaxes);
    mksize=getappdata(0,'markersize');
    mkmark=getappdata(0,'markermark');
    plot(x(:,1),x(:,2),mkmark,'MarkerSize',mksize);
    
    axis image;
    set(gca,'XLim',[-0.2 1.2]);
    set(gca,'YLim',[-0.2 1.2]);
    grid on;
    set(gca,'XTick',[0 0.5 1.0]);
    set(gca,'YTick',[0 0.5 1.0]);
    text(0.52,1.1,snpname,'Color',[1 0 0]);
        
    set(gca,'UserData',x);

return
