function [ans_pairs,ans_matches,N] = connected_comp(pairs,k,matches)
flag = zeros(k,1);
label = zeros(k,1);
G = graph(pairs(:,1),pairs(:,2));
count = 1;
len = size(pairs,1);
for i = 1:len
    t = pairs(i,1);
    if flag(t) == 0
        v = dfsearch(G,t);
        label(v) = count;
        count = count +1;
        flag(v) = 1;
    end
end
mx = max(label);
ans_pairs = {};
ans_matches = {};
lb = zeros(size(pairs,1),1);
for i = 1:size(pairs,1)
    lb(i) = label(pairs(i,1));
end
N = zeros(mx,1);
for i = 1:size(label)
    N(label(i)) = N(label(i)) + 1; 
end
for i = 1:mx
    ans_pairs{i} = [];
    ans_matches{i} = [];
end
for i = 1:len
    ans_pairs{lb(i)} = [ans_pairs{lb(i)};pairs(i,:)];
    ans_matches{lb(i)} = [ans_matches{lb(i)};matches(i,:)];
end
end