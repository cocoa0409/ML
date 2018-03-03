function [q, steps_per_episode] = qlearning(episodes)

% set up parameters and initialize q values
alpha = 0.05;
gamma = 0.99;
num_states = 100;
num_actions = 2;
actions = [-1, 1];
q = zeros(num_states, num_actions);

for i=1:episodes,
  [x, s, absorb] =  mountain_car([0.0 -pi/6], 0);
  %%% YOUR CODE HERE
  [maxq,a]=max(q(s,:));
  if q(s,1)==q(s,2),
      a=ceil(rand-0.5)+1;
  end
  step=0;
  while absorb==0
      % execute the best action or a random action
      if(i>9995),
          plot_mountain_car(x);
                 pause(0.0001);
      end
        [x, snext, absorb] =  mountain_car(x, actions(a));
      % find the best action for the next state and update q value
        [maxq,anext]=max(q(snext,:));
        if q(snext,1)==q(snext,2),
            anext=ceil(rand-0.5)+1;
        end
        reward = -double(absorb == 0);
        q(s,a)=(1-alpha)*q(s,a)+alpha*(reward+gamma*q(snext,anext));
        step=step+1;
        a=anext;
        s=snext;
  
  end
      if(i>9995),
          pause(1);
      end
  steps_per_episode(i) = step;
end