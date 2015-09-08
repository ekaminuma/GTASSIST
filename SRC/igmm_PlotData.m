function igmm_PlotData(handles,x,tmpname)
%
% GTAssist - IGMM 
% by eli@gsc.riken.jp
% 
% (c) 2006 RIKEN GSC
%
showCountLabels(handles,x);
plotRawData(handles,x,tmpname);

return
%---------------------------------------------------------------
function showCountLabels(handles,x)

%colormap(cool);
map=colormap;
mm=[1 22 43 64];
tmpcol=[0 0 0;map(mm(1),:);map(mm(2),:);map(mm(4),:);map(mm(3),:)];
 
%tmpcol=['k','c','b','r','g'];
   
    for ll=-1:3        
        list=find(x(:,3)==ll);
        tmpN=length(list);
        str=sprintf('%d',tmpN);
        
        switch ll
            case -1    
                tmpobj=handles.text15;
                %unknown
            case 0
                tmpobj=handles.text11;
                %NTC
            case 1
                tmpobj=handles.text12;
                %homo1
            case 2
                tmpobj=handles.text14;
                %homo2
            case 3
                tmpobj=handles.text13; 
                %hetero
            otherwise
        end
        set(tmpobj,'String',str);
        set(tmpobj,'ForegroundColor',tmpcol(ll+2,:));
    end
     
    
return
%---------------------------------------------------------
function plotRawData(handles,x,snpname)

map=colormap;
mm=[1 22 43 64];
tmpcol=[map(mm(1),:);map(mm(2),:);map(mm(4),:);map(mm(3),:);0 0 0];

   
    L=x(:,3);
    ltmp=cell(1,1);

    for ll=-1:3     
        list=find(L==ll);
        ltmp{ll+2,1}=list;
    end
    
    %1->unknown,2->NTC,3->homo1,4->homo2,5->hetero
    axes(handles.axes1);
    p1=findobj('Tag','plotobj');
    if ~isempty(p1)
        set(p1(6,1),'XData', x(ltmp{2,1},1),'YData', x(ltmp{2,1},2));
        set(p1(5,1),'XData', x(ltmp{3,1},1),'YData', x(ltmp{3,1},2));
        set(p1(4,1),'XData', x(ltmp{4,1},1),'YData', x(ltmp{4,1},2));
        set(p1(3,1),'XData', x(ltmp{5,1},1),'YData', x(ltmp{5,1},2));
        set(p1(2,1),'XData', x(ltmp{1,1},1),'YData', x(ltmp{1,1},2));
        set(p1(1,1),'XData',2.0,'YData', 2.0);
    else    
        mkmark=getappdata(0,'markermark');
        mksize=getappdata(0,'markersize');
     
        ltmp=setDefaultEmptyData(ltmp);
        
        p1=plot(x(ltmp{2,1},1),x(ltmp{2,1},2),mkmark, ...%NTC'... %'c'
            x(ltmp{3,1},1),x(ltmp{3,1},2),mkmark, ...%homo1 ... %'b'
            x(ltmp{4,1},1),x(ltmp{4,1},2),mkmark, ...%homo2 ... %'g'
            x(ltmp{5,1},1),x(ltmp{5,1},2),mkmark, ...%hetero ... %r
            x(ltmp{1,1},1),x(ltmp{1,1},2),mkmark, ...%unknown ... %'k'
            100.000,100.000,'ro', ...
            'Tag','plotobj','MarkerSize',mksize);% ...
        
        resetEmptyPlotData(p1);
        
        %----------------------------------------------
        %(ltmp)1->unknown,2->NTC,3->homo1,4->homo2,5->hetero     
        %(p1)1->NTC,2->homo1,3->homo2,4->hetero,5->unknown
         for pp=1:5
             set(p1(pp,1),'Color',tmpcol(pp,:));
         end    
        %-------------------------------------------
        set(gca,'FontName','ariel');
        axis image;
        set(gca,'XLim',[-0.2 1.2]);
        set(gca,'YLim',[-0.2 1.2]);
        grid on;
        set(gca,'XTick',[0 0.5 1.0]);
        set(gca,'YTick',[0 0.5 1.0]);
        
        text(0.75,1.1,snpname,'Color',[1 0 0],'FontName','ariel');
        setappdata(0,'origplot',p1);
   
    end 
     
return
%--------------------------------------------------------
function resetEmptyPlotData(p1)

for pp=1:5
    xtmp=get(p1(pp,1),'XData');
    if length(xtmp)==1 & xtmp==100
        set(p1(pp,1),'XData',[],'YData',[]);
    end    
end

return
%--------------------------------------------------------
function [to]=setDefaultEmptyData(ti)

to=ti;
for pp=1:5
    if length(to{pp,1})==0
        to{pp,1}=100.0;
        to{pp,2}=100.0;
    end    
end

return

 
 
