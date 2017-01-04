% converts HMM from quantum representation to classical representation as column-stochastic matrix
% quant_rep is quantum representation consisting of three subsystems
% unitary_mats is array (indexed by 3rd dimension) of unitary matrices representing possible actions to be performed on inner/third subsystem
% n is size of outer/first subsystem
function col_stoch = quantum_to_classical(quant_rep, unitary_mats, n)
% size of inner/third subsystem
m = size(unitary_mats, 1);
% size of middle/second subsystem
q = size(quant_rep, 1) / (m * n);
col_stoch = zeros(m, n);
% iterate over outer blocks of quantum representation / columns of classical representation
for col = 1 : n
    % iterate over middle blocks of quantum representation
    for supp_idx = 1 : q
        % current submatrix
        blk = quant_rep(m*q*(col-1) + m*(supp_idx-1) + 1 : m*q*(col-1) + m*supp_idx, ...
                m*q*(col-1) + m*(supp_idx-1) + 1 : m*q*(col-1) + m*supp_idx);
        % iterate over rows of classical representation
        for row = 1 : m
            % add 1/q to current entry if submatrix matches unitary matrix at current index
            if isequal(blk, unitary_mats(:, :, row))
                col_stoch(row, col) = col_stoch(row, col) + 1/q;
            end
        end
    end
end
end
