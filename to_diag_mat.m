% converts a row vector into a diagonal matrix
function ret = to_diag_mat(vec)
ret = zeros(size(vec, 2), size(vec, 2));
for state = 1 : size(vec, 2)
    ret(state, state) = vec(1, state);
end
end
