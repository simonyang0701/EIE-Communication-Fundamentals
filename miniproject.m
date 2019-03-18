hMod = comm.QPSKModulator;
Rup = 16;  % upsampling rate
hRCTxFilter = comm.RaisedCosineTransmitFilter(...
    'Shape','Normal', ...
    'RolloffFactor',0.5, ...
    'FilterSpanInSymbols',Rup, ...
    'OutputSamplesPerSymbol',Rup);
data = randi([0 3],100,1);
modData = step(hMod,data);
hScope = comm.ConstellationDiagram('SamplesPerSymbol',Rup);
txSig = step(hRCTxFilter,modData);
step(hScope,txSig) %Draw the constellation diagram of QPSK



tb=0:0.01:1;
bits=[1 0 1 1 0 0 1 0 0 1 1 0 0 0 1 1];
A=(2)^0.5;
Tc=1;
fc=1/Tc;%set sampling frequency
wc=2*pi*fc;
sym1=A*sin(wc*2*tb);%represent 00
sym2=A*sin(wc*2*tb+pi/2);%represent 01
sym3=A*sin(wc*2*tb+pi);%represent 10
sym4=A*sin(wc*2*tb+3*pi/2);%represent 11
figure(1)
subplot(2,2,1),plot(sym1)
set(title('00'));
subplot(2,2,2),plot(sym2)
set(title('01'));
subplot(2,2,3),plot(sym3)
set(title('10'));
subplot(2,2,4),plot(sym4)
set(title('11')); %Show theinput value of 00,01,10,11
mod=[];%For QPSK modulation steps
for i=1:2:16;
    if(bits(i)==0 && bits(i+1)==0) mod=[mod sym1];
    elseif(bits(i)==0 && bits(i+1)==1) mod=[mod sym2];
    elseif(bits(i)==1 && bits(i+1)==0) mod=[mod sym3];
    elseif(bits(i)==1 && bits(i+1)==1) mod=[mod sym4];
    end
end
figure(2)
plot(mod)
set(gca,'XTick',[100,200,300,400,500,600,700,800])
set(gca,'XTickLabel',{'2T','4T','6T','8T','10T','12T','14T','16T'})
ylabel('s(t)')




sym5=A*sin(wc*2*tb+7*pi/4);%represent 00
sym6=A*sin(wc*2*tb+3*pi/4);%represent 01
sym7=A*sin(wc*2*tb+5*pi/4);%represent 10
sym8=A*sin(wc*2*tb+pi/4);%represent 11
mod1=[];%For OQPSK modulation steps
for i=1:15;
    if(bits(i)==0 && bits(i+1)==0) mod1=[mod1 sym5];
    elseif(bits(i)==0 && bits(i+1)==1) mod1=[mod1 sym6];
    elseif(bits(i)==1 && bits(i+1)==0) mod1=[mod1 sym7];
    elseif(bits(i)==1 && bits(i+1)==1) mod1=[mod1 sym8];
    end
end

figure(3)
plot(mod1) 
set(gca,'XTick',[200,400,600,800,1000,1200,1400,1500,1600])
set(gca,'XTickLabel',{'2T','4T','6T','8T','10T','12T','14T','15T','16T'})
ylabel('s(t)')


