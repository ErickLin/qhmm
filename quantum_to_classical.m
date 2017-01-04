function col_stoch = quantum_to_classical(quant_rep, unitary_mats, n)
m = size(unitary_mats, 1);
q = size(quant_rep, 1) / (m * n);
col_stoch = zeros(m, n);
for col = 1 : n
    for supp_idx = 1 : q
        blk = quant_rep(m*q*(col-1) + m*(supp_idx-1) + 1 : m*q*(col-1) + m*supp_idx, ...
                m*q*(col-1) + m*(supp_idx-1) + 1 : m*q*(col-1) + m*supp_idx);
        for row = 1 : m
            if isequal(blk, unitary_mats(:, :, row))
                col_stoch(row, col) = col_stoch(row, col) + 1/q;
            end
        end
    end
end
end