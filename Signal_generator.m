 val=validation(str2double(input('Enter the Sampling frequency : ','s')));
 while (val<0)
val=validation(str2double(input('please enter a positive number for the Sampling frequency : ','s')));  
end
    SamplingFrequency=val;
step=1/SamplingFrequency;

val=validation(str2double(input('Enter the Start time : ','s')));
   starttime=val;

val=validation(str2double(input('Enter the end time : ','s')));

   while  val<=starttime
        
        val=validation(str2double(input('invalid..(please enter the ending time  greater than the starting time) : ','s')));
        
   end
      Endtime=val;

ytot=[];


val=validation(str2double(input('Enter the number of break points : ','s')));

   while val>(Endtime-starttime) 
       val=validation(str2double(input('re-enter the number of break points : ','s')));
   end

 breakPoints=val;
 
 n = breakPoints+2;
positions=size(n,1);
positions(1)=starttime;
positions(n)=Endtime;
 


for x = 2:breakPoints+1
    breakPositionsCheck=0;
    prompt= sprintf('Enter break points position number %d : ', x-1);

val=validation(str2double(input((prompt),'s')));


while (breakPositionsCheck==0)
   if(val>positions(x-1)&&val<Endtime)
        positions(x)=val;
        breakPositionsCheck=1;
    else   
    prompt= sprintf('re-enter the break point position number %d : ', x-1);
    val=validation(str2double(input((prompt),'s')));
    positions(x)=val;

    end
end
end

breakPoints=breakPoints+1;
ttot=[];
for x = 1:breakPoints
    prompt = sprintf('Enter type of Signal from %d to %d \n 1.DC,2.Ramp,3.polynomial,4.Exp,5.Sinusoidal\n',positions(x),positions(x+1));
    
signalType=validation(str2double(input((prompt),'s')));

  
        if signalType==1
           prompt='Enter amplitude : ';
           amplitude=input(prompt);
           y=[];
           t=positions(x):step:positions(x+1);
           for t=positions(x):step:positions(x+1)    
           yt=amplitude*ones(1,1);
           y= [y yt];
           end
           
        
        end
        
        if signalType==2
            prompt='Enter slope : ';
            slope=input(prompt);
            prompt='Enter Intercept : ';
            intercept=input(prompt);
           t=positions(x):step:positions(x+1);
            y=(slope*t+intercept).*(t>=0);    
        end
        
        if signalType==3
              prompt='Enter power : ';
             power=input(prompt);
             
            prompt='Enter amplitude : ';
            amplitude=input(prompt);
            p=size(power);
            for i=1:power+1
              if(i<=power)
                   prompt= sprintf('Enter coefficient of t^%d: ',power-(i-1) );
                  p(i)=input(prompt);
              end
               if (i==power+1)
                      prompt='Enter Intercept : ';
                         p(i)=input(prompt);
                   
               end      
            end
             
           t=positions(x):step:positions(x+1);
            y=amplitude*polyval(p,t);       
        end
        
        if signalType==4
           prompt='Enter Amplitude : ';
           amplitude=input(prompt);
           prompt='Enter Exponent : ';
           exponent=input(prompt);
           t=positions(x):step:positions(x+1);
           y=amplitude*exp(exponent*t);
          
        end
         if signalType==5
           prompt='Enter Amplitude : ';
              y=[];
           amplitude=input(prompt);
           prompt='Enter Frequency : ';
           frequency=input(prompt);
           prompt='Enter Phase : ';
           phase=input(prompt);
        
          t=positions(x):step:positions(x+1);
          y = amplitude*sin((2.*3.14.*frequency.*t)+phase);
           
           
        end
      
          ytot=[ ytot y ];
           ttot=[ ttot t];
          
end


y1=zeros(1,SamplingFrequency);
y2=zeros(1,SamplingFrequency);
 ytot=ytot(1:end-breakPoints);
ytot = [y1 ytot y2];

t1=linspace((positions(1)-1),positions(1),((positions(1)-(positions(1)-1)).*SamplingFrequency));
t2=linspace(positions(end),(positions(end)+1),((positions(end)+1)-positions(end)).*SamplingFrequency);

ttot=linspace(starttime,Endtime,((Endtime-starttime).*SamplingFrequency));

ttot=[ t1 ttot t2];
figure;plot(ttot,ytot);
grid on

flag=0;
while 1
    
prompt ='Enter the operation you want to perform on the signal \n 1.Amplitude Scaling \n 2.Time reversal  \n 3.Time shift \n 4.Expanding the signal \n 5.compressing the signal \n 6.None \n 7.Exit the program';
z=validation(str2double(input((prompt),'s')));

 if(flag==0)
   ynew=ytot ;
   ttotnew=ttot;
   flag=1;
 end
       if(flag==1)
           ytot=ynew ;
   ttot=ttotnew;
       end

    switch z
        case 1
             prompt='Enter Amplitude : ';
           amplitude=input(prompt);
            ynew=amplitude*ytot;

            ttotnew=ttot;
           plot(ttotnew,ynew);
           grid on
           case 2
             
            ttotnew=-ttot;
             plot( ttotnew,ynew);
             grid on
           
           case 3
                prompt='for shifting the signal to the left enter positive number \n for shifting the signal to the right enter negative number \n: ';   
          shift=input(prompt);
          ttotnew=ttot- shift;
               plot( ttotnew,  ynew );
                grid on
          case 4
             prompt='Enter expansion value : ';
               expanding=input(prompt);
              ttotnew=expanding.*ttot;
               ynew=ytot ;
               plot( ttotnew,ynew);
                grid on
          
            case 5
             
              prompt='Enter the compression value: ';
                compression=input(prompt);
              ttotnew=ttot./compression;
               ynew=ytot ;
                  plot(ttotnew,ynew);
                   grid on
                
           case 6
                 plot( ttot, ytot);
                  grid on
             break;
                 
            case 7     
                 exit;
           
        otherwise
          fprintf('you have enter a number for 1 to 8 \n');
                   
            
    end

end
