function ret = to_diag_mats(mat)
ret = zeros(size(mat, 2), size(mat, 2), size(mat, 1));
for observ = 1 : size(mat, 1)
    for state = 1 : size(mat, 2)
        ret(state, state, observ) = mat(observ, state);
    end
end
end