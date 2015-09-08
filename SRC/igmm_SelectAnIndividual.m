function igmm_SelectAnIndividual(handles)
%
% GTAssist - IGMM 
% by eli@gsc.riken.jp
% 
% (c) 2006 RIKEN GSC
%
 
    dat=getInfoOfSelectedIndividual(handles);
    igmm_MarkHighlight(handles,dat(3,1),dat(4,1));
    setNewStatus(handles,dat);
    setMembershipProb(handles,dat(5,1));
      
   
return
%----------------------------------------------------
function [dat]=getInfoOfSelectedIndividual(handles)

    pos=get(gca,'currentpoint');
    if 0
        str=sprintf('[X=%.2f,Y=%.2f]',pos(1,1),pos(1,2));
        text(0.05,1.1,str,'tag','position','Fontname','Ariel','FontSize',9);
    end
   
    %----------------------------------------------
    p1=findobj('tag','plotobj');
    pN=size(p1,1);
    tmpmin=100;
    dat=zeros(5,1);
    %----search an individual of min.distance------
    for pp=2:pN %(unknown,hetero,homo2,homo1,NTC)
        tmpx=get(p1(pp,1),'XData');
        tmpy=get(p1(pp,1),'YData');
        N=size(tmpx,2);
    
        
        dist=(tmpx-pos(1,1)).^2+(tmpy-pos(1,2)).^2;
        if min(dist)<tmpmin
           
            %-------get local index-------
            tmpmin=min(dist);
            ltmp=find(dist==tmpmin);
            %-------get general index------
            
            gidx=getGlobalIdxOfIndividual(handles,pp,ltmp(1));
            %-------save info--------------
            %(org)1->NTC,2->homo1,3->homo2,4->hetero,5->unknown
            %(p1)2->unknown,3->hetero,4->homo2,5->homo1,6->NTC
            dat(1,1)=pp;%plot-index
            dat(2,1)=ltmp(1);
            dat(3,1)=tmpx(ltmp(1));
            dat(4,1)=tmpy(ltmp(1));
            dat(5,1)=gidx;
           
        end    
    end
    
return
%----------------------------------------------------
function setNewStatus(handles,dat)

   classlist={'ERROR';'unknown';'hetero';'homo2';'homo1';'NTC'};
   
    classid=classlist{dat(1,1),:};
    tmp=getappdata(0,'indivnames');
    str0=sprintf('%s',tmp{dat(5,1),1});
    str1=sprintf('%d',dat(5,1));
    str2=sprintf('%.4g',dat(3,1));
    str3=sprintf('%.4g',dat(4,1));
    str4=sprintf('%s',classid);
    set(handles.edit0,'String',str0);
    set(handles.edit1,'String',str1);
    set(handles.edit2,'String',str2);
    set(handles.edit3,'String',str3);
    set(handles.edit4,'String',str4);
    
return
%------------------------------------------------------
function gidx=getGlobalIdxOfIndividual(handles,dat1,dat2)

didx=getPlotIdx2DataIdx(dat1);
x=get(handles.axes1,'UserData');
list=find(x(:,3)==didx);
if length(list)==0
        gidx=NaN;
        return
end    
if dat2>length(list)
  
    if ~isempty(uiwait(errordlg('Cannot specify the individual','ERROR')))
        delete(handles.figure1);
    end
end    

gidx=list(dat2);
setappdata(0,'backupclass',[gidx x(gidx,:)]);

return
%-----------------------------------------------------
function out=getPlotIdx2DataIdx(in)
%(p1)1->NTC,2->homo1,3->homo2,4->hetero,5->unknown
% 0,1,2,3,-1
%'ERROR';'unknown';'hetero';'homo2';'homo1';'NTC'};
tmpidx=[NaN -1 3 2 1 0];
out=tmpidx(in);

return
%-----------------------------------------
function setMembershipProb(handles,idx)

pr_igmm=zeros(4,1);
pr_igmm=igmm_GetMembershipProb(handles,idx);
igmm_PlotMembershipProb(handles,pr_igmm )

return
%-----------------------------------------

