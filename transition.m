% performs transition action in quantum setting
% Q is quantum representation of transition matrix
% p_dm is current state in density matrix form
function new_state = transition(U, p_dm)
% size of inner/first subsystem
n = size(p_dm, 1);
% size of middle/second subsystem
q = size(U, 1) / (n * n);
% uniform distribution
randomness_dm = to_diag_mat(ones(1, q) / q);
% output initialized to state 1 by convention of transition matrix
next_x = zeros(1, n);
next_x(1) = 1;
next_x_dm = to_diag_mat(next_x);
% compose the three subsystems
sys_dm = kron(kron(p_dm, randomness_dm), next_x_dm);
% perform main unitary transformation
res = U * sys_dm * U';
% isolate inner subsystem to obtain result
new_state = partial_trace_left(partial_trace_left(res, n), q);
end
