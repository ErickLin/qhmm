T = [.5 0 .5; .5 .5 0; 0 .5 .5];
C = [0.3 0.4 0.9; 0.7 0.6 0.1];
disp('transition matrix: ');
disp(sym(T));
disp('observation probability matrix: ');
disp(sym(C));
n = size(T, 1);
m = size(C, 1);
p = [1; 0; 0];
disp('p_0 =');
disp(sym(p));
for i = 1 : 2
    p = T * p;
    disp(['p_', num2str(i), ' =']);
    disp(sym(p));
    y = C * p;
    disp(['y_', num2str(i), ' =']);
    disp(sym(y));
end

U = classical_to_quantum(T, construct_unitary_mats(circshift(eye(n), 1)));
imagesc(U);
Q = classical_to_quantum(C, construct_unitary_mats(circshift(eye(m), 1)));
%imagesc(Q);
disp('transition matrix reconstructed: ');
disp(sym(quantum_to_classical(U, construct_unitary_mats(circshift(eye(n), 1)), n)));
disp('observation probability matrix reconstructed: ');
disp(sym(quantum_to_classical(Q, construct_unitary_mats(circshift(eye(m), 1)), n)));
p = [1; 0; 0];
p_dm = p * p'; % dm - density matrix
disp('rho_p_0 =');
disp(sym(p_dm));
for i = 1 : 2
    p_dm = transition(U, p_dm);
    [p_dm, observation] = observe(Q, p_dm, m);
    disp(['rho_p_', num2str(i), ' =']);
    disp(sym(p_dm));
    disp(['rho_y_', num2str(i), ' =']);
    disp(sym(observation));
end

%{
T2 = [1 0 3 2; 2 1 0 0; 0 1 0 1; 0 1 0 0] / 3;
disp(sym(T2));
n2 = size(T2, 1);
U2 = classical_to_quantum(T2, construct_unitary_mats(circshift(eye(n2), 1)));
imagesc(U2)
disp(sym(quantum_to_classical(U2, construct_unitary_mats(circshift(eye(n2), 1)), n2)));
%}