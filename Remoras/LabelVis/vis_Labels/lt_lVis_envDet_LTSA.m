function [prevDet,nextDet] = lt_lVis_envDet_LTSA()

global REMORA
next = [];
prev = [];

% detection groups
labels = {'', '2', '3', '4', '5', '6', '7', '8'};
[ltsaS,ltsaE] = lt_lVis_get_ltsa_range;

for iDets = 1:length(labels)
    detId = sprintf('detection%s', labels{iDets});
    if isfield(REMORA.lt.lVis_det.(detId),'starts')
        labs = REMORA.lt.lVis_det.(detId).starts;
        next(iDets) = labs(find(labs>ltsaE,1));
        prev(iDets) = labs(find(labs<ltsaS,1,'last'));
    end
end

if ~isempty(next)
    next_sort = sort(next);
    nextDet = next_sort(1);
else
    disp('Last detection! No detections found after current window for this LTSA file')
    nextDet = [];
end

if ~isempty(prev)
    prev_sort = sort(prev);
    prevDet = prev_sort(end);
else
    disp('First detection! No detections found prior to current window for this LTSA file')
    prevDet = [];
end
