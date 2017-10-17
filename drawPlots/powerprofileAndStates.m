for i=1:16 
    g=sprintf('%d ', FBS{i}.state); 
    fprintf('state: %s , power = %d\n', g , FBS{i}.powerProfile(50000)); 
end