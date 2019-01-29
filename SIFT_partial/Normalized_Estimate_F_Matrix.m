function F_matrix = Normalized_Estimate_F_Matrix(norm2Dpts1,norm2Dpts2)
%%% Reshaping the matrix into 8X9
a1 = norm2Dpts1;
a1_u = a1 .* repmat(norm2Dpts2(:,1), [1,3]);
a1_v = a1 .* repmat(norm2Dpts2(:,2), [1,3]);
A = [a1_u a1_v a1];
%%% SVD of W and then taking last column
[~,~,V] = svd(A);
f = V(:,end);

F = reshape(f, [3,3])';
%%% Making it as a rank 2 matrix
[U,S,V] = svd(F);
S(3,3) = 0;
F = U*S*V';
F_matrix = F;
end