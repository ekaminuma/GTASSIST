function msm_PlotPdfs(tmpaxes,idat,idx,zz,snpname)
%
% GTAssist - MSM
% by eli@gsc.riken.jp
% 
% (c) 2006 RIKEN GSC
%
       axes(tmpaxes);   
       cla(tmpaxes);
       mkmark=getappdata(0,'markermark');
       mksize=getappdata(0,'markersize');
       plot(idat(:,1),idat(:,2),mkmark,'MarkerSize',mksize);    
       hold on;
       contour(idx,idx,zz,20);
       
        %colorbar;  
        axis image;
        set(gca,'XLim',[-0.2 1.2]);
        set(gca,'YLim',[-0.2 1.2]);
        grid on;
        set(gca,'XTick',[0 0.5 1.0]);
        set(gca,'YTick',[0 0.5 1.0]);
        text(0.52,1.1,snpname,'Color',[1 0 0]);
        
       map=jet(64);
       colormap(map(30:55,:));
       %------ save data----------------
       %set(tmpaxes,'UserData',zz);
       
return

