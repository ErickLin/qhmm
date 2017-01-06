% performs observation action in quantum setting
% Q is quantum representation of observation matrix
% p_dm is current state in density matrix form
% m is size of outer/third subsystem
function [new_state, observation] = observe(Q, p_dm, m)
% size of inner/first subsystem
n = size(p_dm, 1);
% size of middle/second subsystem
q = size(Q, 1) / (n * m);
% uniform distribution
randomness_dm = to_diag_mat(ones(1, q) / q);
% output initialized with all its weight on index 1 by convention of observation matrix
observation = zeros(1, m);
observation(1) = 1;
observ_dm = to_diag_mat(observation);
% compose the three subsystems
sys_dm = kron(kron(p_dm, randomness_dm), observ_dm);
% perform main unitary transformation
res = Q * sys_dm * Q';
% isolate outer subsystem to obtain new state (which should stay the same)
new_state = partial_trace_right(partial_trace_right(res, m), q);
% isolate inner subsystem to obtain result
observation = partial_trace_left(partial_trace_left(res, n), q);
end
