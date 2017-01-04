% converts HMM from classical representation to quantum representation consisting of three subsystems
% col_stoch is classical representation as column-stochastic matrix
% unitary_mats is array (indexed by 3rd dimension) of unitary matrices representing possible actions to be performed on inner/third subsystem
function quant_rep = classical_to_quantum(col_stoch, unitary_mats)
% check that col_stoch is 2-dimensional and column-stochastic
if size(size(col_stoch), 2) ~= 2 || ~isequal(sum(col_stoch, 1), ones(1, size(col_stoch, 2)))
    throw(MException('quant_rep:invalidInput', 'Input not a valid HMM'));
else
    % size of outer/first subsystem which is the number of states
    n = size(col_stoch, 2);
    % size of inner/third subsystem which is the output
    m = size(col_stoch, 1);
    % take reciprocals of all nonzero elements and convert to fractional representation
    recips = 1 ./ sym(nonzeros(col_stoch));
    % size of middle/second subsystem which is the LCM of the reciprocals
    q = lcm(1, recips(1));
    for i = 2 : size(recips)
        q = lcm(q, recips(i));
    end
    q = double(q);
%    quant_rep = zeros(n * q * m, n * q * m);
    % array of matrices comprising outer subsystem before they are composed into a larger block-diagonal matrix
    outer = cell([1, n]);
    % iterate over columns of classical representation
    for col = 1 : n
        % array of matrices comprising middle subsystem
        mid = cell([1, q]);
        % current index of mid
        supp_idx = 1;
        % iterate over rows of classical representation
        for row = 1 : m
            % fill mid with corresponding unitary matrix as many times as indicated by current element in classical representation
            for ntimes = 1 : q * sym(col_stoch(row, col))
                inner = unitary_mats(:, :, row);
                mid{1, supp_idx} = inner;
                supp_idx = supp_idx + 1;
            end
%{
            for i = supp_idx : q
                mid{1, i} = %zeros(m);%circshift(eye(m), m - 1);
            end
%}
        end
        % compose matrices in mid into larger block-diagonal matrix and concatenate to outer
        outer{1, col} = blkdiag(mid{1, :});
    end
    % compose matrices in outer into complete quantum representation
    quant_rep = blkdiag(outer{1, :});
end
end
