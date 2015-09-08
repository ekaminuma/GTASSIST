function msm_CalcOrder(handles)
%
% GTAssist - MSM
% by eli@gsc.riken.jp
% 
% (c) 2006 RIKEN GSC
%
%------ranking----------------------------------
[N_SNP,mom]=calcRanking(handles);
%------sort--------------------------------------
[mom_sort,mom_idx]=sort(mom,'ascend');
%------updates-----------------------------------
[vars]=updateAppData(N_SNP,mom_idx,mom_sort);
updateTmpMatFiles(N_SNP,mom_idx);
updateListBoxAndFigs(handles,vars);
%------button-on--------------------------------
msm_CheckButtonSave(handles);
return
%------------------------------------------------
function [N_SNP,mom]=calcRanking(handles)

    %-----load ideal data-----------------
    d=load('tmp_0.mat');
    zz_id=d.zz;
    idx_id=d.idx;
    
    %-----load test data-----------------
    list_entries = get(handles.listbox1,'String');
    N_SNP=size(list_entries,1);
    
    %-----calculate ranking---------------
    mom=zeros(N_SNP,1);
    for nn=1:N_SNP
        % data load
        tmpname=sprintf('tmp_%d.mat',nn);
        d=load(tmpname);
        zz=d.zz;
        idx=d.idx;
        % calculate MOM
        zz=zz/sum(sum(zz));
        mzz=zeros(length(idx));
        mzz=min(zz,zz_id); 
        mom(nn)=1-sum(sum(mzz));
        %
    end
    %-------------------------------------
return
%------update(1) flist in appdata-----------------
function [vars]=updateAppData(N_SNP,mom_idx,mom_sort)

    vars=cell(1,1);
    flist=getappdata(0,'filelist');
    nflist=cell(1,1);
    for nn=1:N_SNP
        filename=flist{mom_idx(nn),1};
        [tp,tmpname,te, tv] = fileparts(filename) ;
        nflist{nn,1}=filename;
        vars{nn,1}=sprintf('[%d] %s   %2.3g',nn,tmpname,mom_sort(nn));
    end
    setappdata(0,'filelist',nflist);
    setappdata(0,'mom_sort',mom_sort);
    
return
%------update(2) listbox and figs------------------
function updateListBoxAndFigs(handles,vars)

    set(handles.listbox1,'String',vars);
    set(handles.listbox1,'Value',1);%select best SNP
    msm_PlotData(handles,1);%plot the best SNP
    
return
%------update(3) tmp.mat ------------------------
function updateTmpMatFiles(N_SNP,mom_idx)

    for nn=1:N_SNP
        oldname=sprintf('tmp_%d.mat',nn);
        tmpname=sprintf('tmp_%d.bk',nn);
        copyfile(oldname,tmpname);
    end
    for nn=1:N_SNP
        tmpname=sprintf('tmp_%d.bk',mom_idx(nn));
        newname=sprintf('tmp_%d.mat',nn);
        copyfile(tmpname,newname);
        delete(tmpname);
    end
return



