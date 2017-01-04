% performs transition action in quantum setting
% Q is quantum representation of transition matrix
% p_dm is current state in density matrix form
function new_state = transition(U, p_dm)
% size of inner/first subsystem
n = size(p_dm, 1);
% size of middle/second subsystem
q = size(U, 1) / (n * n);
% uniformly random vector
randomness = normc(ones(q, 1));
randomness_dm = randomness * randomness';
% output vector starts at state 1 due to design of transition matrix
next_p = zeros(n, 1);
next_p(1) = 1;
next_p_dm = next_p * next_p';
% compose the three subsystems
sys_dm = kron(kron(p_dm, randomness_dm), next_p_dm);
% perform main unitary transformation
res = U * sys_dm * U';
% isolate inner subsystem to obtain result
new_state = partial_trace_left(partial_trace_left(res, n), q);
end
