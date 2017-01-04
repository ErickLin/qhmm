% performs observation action in quantum setting
% Q is quantum representation of observation matrix
% p_dm is current state in density matrix form
% m is size of outer/third subsystem
function [new_state, observation] = observe(Q, p_dm, m)
% size of inner/first subsystem
n = size(p_dm, 1);
% size of middle/second subsystem
q = size(Q, 1) / (n * m);
% uniformly random vector
randomness = normc(ones(q, 1));
randomness_dm = randomness * randomness';
% output vector starts with all of its weight on index 1 due to design of observation matrix
observation = zeros(m, 1);
observation(1) = 1;
observ_dm = observation * observation';
% compose the three subsystems
sys_dm = kron(kron(p_dm, randomness_dm), observ_dm);
% perform main unitary transformation
res = Q * sys_dm * Q';
% isolate outer subsystem to obtain new state (which should stay the same)
new_state = partial_trace_right(partial_trace_right(res, m), q);
% isolate inner subsystem to obtain result
observation = partial_trace_left(partial_trace_left(res, n), q);
end
