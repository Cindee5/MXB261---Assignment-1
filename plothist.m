%% SECTION TITLE
% DESCRIPTIVE TEXT
% MXB261 - Modelling and Simulation Science Assignment 1
% Part 1 - A Biased Random Walk - 10 marks

function plotHistogram = plothist(s,w,e)
maximum_rows = 99;
maximum_columns = 99;

N = [100, 200, 100, 200];
P = [1, 1, randi([1 maximum_columns]), randi([1 maximum_columns])];

for i=1:4

    M = gravity_random_walk(N,P,s,w,e);
    subplot(2,2,i);
    bar(M);
    xlabel('Grid position')
    ylabel('No of particles')
    ylim([0 13])
    title(["N = " + N(i) "P = " + P(i)])
    sgtitle('Biased Random Walk')
end


    function endwalk = gravity_random_walk(N,P,s,w,e)

        %inputs N (no of particles), P (start position), s (south), w (west), e
        %(east)

        %maximum rows and column parameters
        maximum_rows = 99;
        maximum_columns = 99;

        %initialising end matrix containing the end column position of each
        %particle
        endwalk = zeros(maximum_rows,maximum_columns);


        %for each particle
        for k = 1:N
            %initialise the particle's start position (rows,columns)
            for a = 1: length(N)
                if P(a) == 1
                    P(a) = 50;
                end
            end

            position = [1,P];
            while (position(1) < maximum_rows) && (endwalk(position(1)+1,position(2)) == 0)
                u = rand;

                % particle moves South
                if u <= s
                    position(1) = position(1) + 1;

                    % particle moves East
                elseif (u > s) && (u <= (s+e))
                    if position(2) == maximum_columns
                        if endwalk(position(1),1) == 0
                            position(2) = 1;
                        end
                    else
                        if endwalk(position(1),position(2)+1) == 0
                            position(2) = position(2) + 1;
                        end
                    end

                    % particle moves West
                elseif (u > (s+e)) && (u <= (s+e+w))
                    if position(2) == 1
                        if endwalk(position(1),maximum_columns) == 0
                            position(2) = maximum_columns;
                        end
                    else
                        if endwalk(position(1),position(2)-1) == 0
                            position(2) = position(2) - 1;
                        end
                    end
                end
            end

            endwalk(position(1),position(2)) = 1;
        end

        endwalk = sum(endwalk);

    end

end

