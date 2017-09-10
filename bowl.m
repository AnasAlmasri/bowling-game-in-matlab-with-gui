function [] = bowl(p) % FUNCTION BOWL() STARTS
    % bowl() is a function that calculates scores of a bowling game
    % Input is an integers vector including the player's score of each ball
    % Output is the final score + a table of game details
    
    % check if input is valid for a full game
    if length(p)<12 || length(p)>21 % if p is less than the minimum input (12 strikes)
        disp('-1') % output -1
        return; % stop execution
    end % endif statement

    % define variables
    ball = zeros(1,21); % create vector ball consisting of 21 zeros
    strikes = zeros(1,21); % create vector strikes consisting of 21 zeros
    spares = zeros(1,21); % create vector spares consisiting of 21 zeros
    frame_score = zeros(1,21); % create vector frame_score consisting of 21 zeros
    j=1; % used in manipulating vector ball's values
    score=0; % set score to zero
    frames = 1:10; % create vector frames
    ball1 = zeros(1,10); % create vector ball1
    ball2 = zeros(1,10); % create vector ball2
    type = cell(1,10); % create cell array type
    f=1; % used in manipulating ball1 and ball2 values
    h=1; % used in manipulating vector type values

    % create vector ball with correct numbers depending on p
    for i=1:length(p) % loop for p
        ball(1,j)=p(1,i); % set value p to ball element
        % put a zero after each strike in ball
        if j<19 && mod(j,2)~=0 && ball(1,j)==10
            ball(1,j+1)=0;
            j=j+1; % increment j to skip the next element
        else
            ball(1,j)=p(1,i);
        end % endif statement
        j=j+1; % increment j by one
    end % end for loop
    
    % check for strikes
    for a=1:2:19 % loop for odd elements in ball
        if ball(1,a)==10 % if the frame is a strike
            strikes(1,a)=1; % set strikes element to one
        end % endif statement
    end % end for loop

    % check for spares
    for b=3:2:21 % loop for spares
        % if the previous frame is a spare
        if ball(1,b-2)~=10 && ball(1,b-1)+ball(1,b-2)==10
            spares(1,b-2)=1; % set the first spares element of the previous frame to one
        end % endif statement
    end % end for loop

    % calculate score
    for c=1:21 % loop for vector ball elements
        if c<19 && strikes(1,c)==1 % if the frame is a strike
            if strikes(1,c+2)==0 % if the next frame is not a strike
                score = score + ball(1,c) + ball(1,c+2) + ball(c+3); % add the next two balls
            else % if the next frame is a strike
                score = score + ball(1,c) + ball(1,c+2) + ball(1,c+4); % add the next two balls
            end %endif statement
        elseif c<19 && spares(1,c)==1 % if the frame is a spare
            score = score + ball(1,c) + ball(1,c+2); % add the next ball
        else % if the frame is open
            score = score + ball(1,c); % add the balls of the frame
        end % endif statement

        % calculate the score of each frame
        if c<20 && mod(c,2)==0
            frame_score(1,c)=score;
        elseif c==21
            frame_score(1,c)=score;
        end % endif statement
    end % end for loop
    
    % set each zero element in frame_score to be empty
    frame_score(frame_score==0)=[];
    
    % determine how many pins were knocked down in each first
    % and second ball
    for e=1:20 % loop for vector ball elements
        if mod(e,2)~=0 % if e is odd
            ball1(1,f)=ball(1,e); % set value of ball to ball1
        elseif mod(e,2)==0 % if e is even
            ball2(1,f)=ball(1,e); % set value of ball to ball2
            f=f+1; % increment f by one
        end %endif statement
    end % end for statement

    % create vector type connsisting of frame types
    for g=1:2:19 % loop for balls
        if strikes(1,g)==1 % if the frame is a strike
            if g==19 % if it is is the 10th frame
                if score>=300
                    type(1,h)={'Perfect Game!'};
                else
                    type(1,h)={'Strike + Bonus'};
                end
                break;
            else % if it is not the 10th frame
                type(1,h)={'Strike'};
                h=h+1;
                continue;
            end %endif statement
        elseif spares(1,g)==1 % if the frame is a spare
            if g==19 % if it is the 10th frame
                type(1,h)={'Spare + Bonus'};
                break;
            else % if it is not the 10th frame
                type(1,h)={'Spare'};
                h=h+1;
                continue;
            end % endif statement
        else 
            type(1,h)={'Open'};
            h=h+1;
        end % endif statement
    end % end for loop
    
    % output the final score
    if score>300
        fprintf('Input values exceeded the acceptable amount.\n')
        return;
    else
        fprintf('Final score is: %d\n',score)
    end
    
    % output the game summary in form of a table
    f=figure; % create figure
    headers={'Frame','Ball 1','Ball 2','Type','Score'}; % assign headers
    % create cell array 'data' consisting of game data ( each frame is in a
    % different line)
    data = {frames(1,1),ball1(1,1),ball2(1,1),type{1,1},frame_score(1,1);...
        frames(1,2),ball1(1,2),ball2(1,2),type{1,2},frame_score(1,2);...
        frames(1,3),ball1(1,3),ball2(1,3),type{1,3},frame_score(1,3);...
        frames(1,4),ball1(1,4),ball2(1,4),type{1,4},frame_score(1,4);...
        frames(1,5),ball1(1,5),ball2(1,5),type{1,5},frame_score(1,5);...
        frames(1,6),ball1(1,6),ball2(1,6),type{1,6},frame_score(1,6);...
        frames(1,7),ball1(1,7),ball2(1,7),type{1,7},frame_score(1,7);...
        frames(1,8),ball1(1,8),ball2(1,8),type{1,8},frame_score(1,8);...
        frames(1,9),ball1(1,9),ball2(1,9),type{1,9},frame_score(1,9);...
        frames(1,10),ball1(1,10),ball2(1,10),type{1,10},frame_score(1,10)};
    % create uitable
    uitable(f,'Position',[0 0 450 300],'Data',data, 'ColumnName',headers, 'ColumnWIdth',{75});
end % END OF FUNCTION BOWL()