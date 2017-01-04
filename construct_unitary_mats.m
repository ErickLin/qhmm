function unitary_mats = construct_unitary_mats(unitary_mat)
n = size(unitary_mat, 1);
unitary_mats = zeros(n, n, n);
unitary_mats(:, :, 1) = eye(n);
unitary_mats(:, :, 2) = unitary_mat;
for i = 3 : n
    unitary_mats(:, :, i) = unitary_mats(:, :, i - 1) * unitary_mat;
end
end