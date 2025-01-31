// Define the 1D chaotic map function
tic()
function y = chaotic_map_1d(x, r, map_type)
    select map_type
    case "logistic" then
        y =r*x*(1 - x) // Logistic map
        end
endfunction
//getting_audio
[z,y]=loadwave("Test.wav")
iter_length=length(z)
// Set parameters
x0 = 0.5;       // Initial condition (range between 0 to 1)
r = 3.9;        // Parameter 'r' (range between 3.5679 to 4)
n_iterations = iter_length; // Number of iterations
map_type = "logistic"; // Choose "logistic", "tent", or "sin"

// Initialize the x array
x = zeros(1, n_iterations);
x(1) = x0;

// Generate the chaotic sequence
for i = 2:n_iterations
  x(i) = chaotic_map_1d(x(i-1), r, map_type);
end
//plot(1:n_iterations, x, 'b-', 'LineWidth', 1.5);
//fusion salting map with audio data
for inte = 1:iter_length
    salted_wav(inte)=x(inte)+z(inte)
    inte = inte+1
end
savewave("encrypted_audio",salted_wav)
//decryption using chaotic map
for decry= 1:iter_length
    decry_wav(decry)=salted_wav(decry)-x(decry)
    decry = decry+1
end
savewave("decrypted_audio",decry_wav)
computation_time=toc()
disp(computation_time)
subplot(3,2,1)
plot(z)
xlabel("Original Audio")
subplot(3,1,2)
plot(salted_wav)
xlabel("Encrypted Audio")
subplot(3,1,3)
plot(decry_wav)
xlabel("Decrypted Audio")
subplot(3,2,2)
plot(x)
xlabel("Logistic_Map")
