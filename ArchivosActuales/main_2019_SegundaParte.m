
%% -------------------------- Carga de datos -----------------------------
clear all; close all; clc;

[Puntos,Angulos,Vectores,Datos,FramesEventos,...
    Inercia,Antropometria,Cinematica]  = Inicializacion_SegundaParte();

FrameRHS = FramesEventos.FrameRHS;
FrameRHS2 = FramesEventos.FrameRHS2;
FrameRTO = FramesEventos.FrameRTO;

FrameLHS = FramesEventos.FrameLHS;
FrameLHS2 = FramesEventos.FrameLHS2;
FrameLTO = FramesEventos.FrameLTO;

fm = Datos.info.Cinematica.frequency;

%% .................. Calculos de Angulos Euler ...........................

% Inicializaciones

for i=1:length(Vectores.LN_MusloD)
    
    %-------------------------- Calculo Muslo
    
    Vectores.LN_MusloD(i,:) = cross(Vectores.K_MusloD(i,:),Vectores.K_Global);
    Vectores.LN_MusloD(i,:) = Vectores.LN_MusloD(i,:)/norm(Vectores.LN_MusloD(i,:));
    Vectores.LN_MusloI(i,:) = cross(Vectores.K_MusloI(i,:),Vectores.K_Global);
    Vectores.LN_MusloI(i,:) = Vectores.LN_MusloI(i,:)/norm(Vectores.LN_MusloI(i,:));
    
    % Alfas
    
    [Angulos.AlfaMusloD(i)]  = Angulos_Coseno(Vectores.I_Global,...
        Vectores.LN_MusloD(i,:),Vectores.J_Global);
    
    [Angulos.AlfaMusloI(i)]  = Angulos_Coseno(Vectores.I_Global,...
        Vectores.LN_MusloI(i,:),Vectores.J_Global);
    
    % Betas
    
    Angulos.BetaMusloD(i) = acosd(dot(Vectores.K_Global,Vectores.K_MusloD(i,:)));
    Angulos.BetaMusloI(i) = acosd(dot(Vectores.K_Global,Vectores.K_MusloI(i,:)));
    
    % Gammas
    
    [Angulos.GammaMusloD(i)]  = Angulos_Coseno(Vectores.I_MusloD(i,:),...
        Vectores.LN_MusloD(i,:),-Vectores.J_MusloD(i,:));
   
    [Angulos.GammaMusloI(i)]  = Angulos_Coseno(Vectores.I_MusloI(i,:),...
        Vectores.LN_MusloI(i,:),-Vectores.J_MusloI(i,:));
    
    %-------------------------- Calculo Pierna
    
    Vectores.LN_PiernaD(i,:) = cross(Vectores.K_PiernaD(i,:),Vectores.K_Global);
    Vectores.LN_PiernaD(i,:) = Vectores.LN_PiernaD(i,:)/norm(Vectores.LN_PiernaD(i,:));
    Vectores.LN_PiernaI(i,:) = cross(Vectores.K_PiernaI(i,:),Vectores.K_Global);
    Vectores.LN_PiernaI(i,:) = Vectores.LN_PiernaI(i,:)/norm(Vectores.LN_PiernaI(i,:));
    
        % Alfas
    
    [Angulos.AlfaPiernaD(i)]  = Angulos_Coseno(Vectores.I_Global,...
        Vectores.LN_PiernaD(i,:),Vectores.J_Global);
    
    [Angulos.AlfaPiernaI(i)]  = Angulos_Coseno(Vectores.I_Global,...
        Vectores.LN_PiernaI(i,:),Vectores.J_Global);
    
    % Betas
    
    Angulos.BetaPiernaD(i) = acosd(dot(Vectores.K_Global,Vectores.K_PiernaD(i,:)));
    Angulos.BetaPiernaI(i) = acosd(dot(Vectores.K_Global,Vectores.K_PiernaI(i,:)));
    
    % Gammas
    
    [Angulos.GammaPiernaD(i)]  = Angulos_Coseno(Vectores.I_PiernaD(i,:),...
        Vectores.LN_PiernaD(i,:),Vectores.J_PiernaD(i,:));
   
    [Angulos.GammaPiernaI(i)]  = Angulos_Coseno(Vectores.I_PiernaI(i,:),...
        Vectores.LN_PiernaI(i,:),Vectores.J_PiernaI(i,:));
    
    %-------------------------- Calculo Pie
    
    Vectores.LN_PieD(i,:) = cross(Vectores.K_PieD(i,:),Vectores.K_Global);
    Vectores.LN_PieD(i,:) = Vectores.LN_PieD(i,:)/norm(Vectores.LN_PieD(i,:));
    Vectores.LN_PieI(i,:) = cross(Vectores.K_PieI(i,:),Vectores.K_Global);
    Vectores.LN_PieI(i,:) = Vectores.LN_PieI(i,:)/norm(Vectores.LN_PieI(i,:));
    
    % Alfas
    
    [Angulos.AlfaPieD(i)]  = Angulos_Coseno(Vectores.I_Global,...
        Vectores.LN_PieD(i,:),Vectores.J_Global);
    
    [Angulos.AlfaPieI(i)]  = Angulos_Coseno(Vectores.I_Global,...
        Vectores.LN_PieI(i,:),Vectores.J_Global);
    
    % Betas
    
    Angulos.BetaPieD(i) = acosd(dot(Vectores.K_Global,Vectores.K_PieD(i,:)));
    Angulos.BetaPieI(i) = acosd(dot(Vectores.K_Global,Vectores.K_PieI(i,:)));
    
    % Gammas
    
    Angulos.GammaPieD(i) = asind(dot(cross(Vectores.LN_PieD(i,:),Vectores.I_PieD(i,:)),...
        Vectores.K_PieD(i,:)));
    
    Angulos.GammaPieI(i)  = asind(dot(cross(Vectores.LN_PieI(i,:),Vectores.I_PieI(i,:)),...
        Vectores.K_PieI(i,:)));
end

% ........... Derivadas Primera y Segunda de Angulos de Euler .............

%........... Derivadas Primeras

% Muslo 

Angulos.AlfaMusloD_Derivada = Derivada_Vector(Angulos.AlfaMusloD, fm);
Angulos.AlfaMusloI_Derivada = Derivada_Vector(Angulos.AlfaMusloI,fm);

Angulos.BetaMusloD_Derivada = Derivada_Vector(Angulos.BetaMusloD,fm);
Angulos.BetaMusloI_Derivada = Derivada_Vector(Angulos.BetaMusloI,fm);

Angulos.GammaMusloD_Derivada = Derivada_Vector(Angulos.GammaMusloD,fm);
Angulos.GammaMusloI_Derivada = Derivada_Vector(Angulos.GammaMusloI,fm);

% Pierna

Angulos.AlfaPiernaD_Derivada = Derivada_Vector(Angulos.AlfaPiernaD, fm);
Angulos.AlfaPiernaI_Derivada = Derivada_Vector(Angulos.AlfaPiernaI,fm);

Angulos.BetaPiernaD_Derivada = Derivada_Vector(Angulos.BetaPiernaD,fm);
Angulos.BetaPiernaI_Derivada = Derivada_Vector(Angulos.BetaPiernaI,fm);

Angulos.GammaPiernaD_Derivada = Derivada_Vector(Angulos.GammaPiernaD,fm);
Angulos.GammaPiernaI_Derivada = Derivada_Vector(Angulos.GammaPiernaI,fm);

% Pie

Angulos.AlfaPieD_Derivada = Derivada_Vector(Angulos.AlfaPieD, fm);
Angulos.AlfaPieI_Derivada = Derivada_Vector(Angulos.AlfaPieI,fm);

Angulos.BetaPieD_Derivada = Derivada_Vector(Angulos.BetaPieD,fm);
Angulos.BetaPieI_Derivada = Derivada_Vector(Angulos.BetaPieI,fm);

Angulos.GammaPieD_Derivada = Derivada_Vector(Angulos.GammaPieD,fm);
Angulos.GammaPieI_Derivada = Derivada_Vector(Angulos.GammaPieI,fm);

%%%% ........... Derivadas Segundas

% Muslo

Angulos.AlfaMusloD_Derivada2da = Derivada_Vector(Angulos.AlfaMusloD_Derivada, fm);
Angulos.AlfaMusloI_Derivada2da = Derivada_Vector(Angulos.AlfaMusloI_Derivada,fm);

Angulos.BetaMusloD_Derivada2da = Derivada_Vector(Angulos.BetaMusloD_Derivada,fm);
Angulos.BetaMusloI_Derivada2da = Derivada_Vector(Angulos.BetaMusloI_Derivada,fm);

Angulos.GammaMusloD_Derivada2da = Derivada_Vector(Angulos.GammaMusloD_Derivada,fm);
Angulos.GammaMusloI_Derivada2da = Derivada_Vector(Angulos.GammaMusloI_Derivada,fm);

% Pierna

Angulos.AlfaPiernaD_Derivada2da = Derivada_Vector(Angulos.AlfaPiernaD_Derivada, fm);
Angulos.AlfaPiernaI_Derivada2da = Derivada_Vector(Angulos.AlfaPiernaI_Derivada,fm);

Angulos.BetaPiernaD_Derivada2da = Derivada_Vector(Angulos.BetaPiernaD_Derivada,fm);
Angulos.BetaPiernaI_Derivada2da = Derivada_Vector(Angulos.BetaPiernaI_Derivada,fm);

Angulos.GammaPiernaD_Derivada2da = Derivada_Vector(Angulos.GammaPiernaD_Derivada,fm);
Angulos.GammaPiernaI_Derivada2da = Derivada_Vector(Angulos.GammaPiernaI_Derivada,fm);

% Pie

Angulos.AlfaPieD_Derivada2da = Derivada_Vector(Angulos.AlfaPieD_Derivada, fm);
Angulos.AlfaPieI_Derivada2da = Derivada_Vector(Angulos.AlfaPieI_Derivada,fm);

Angulos.BetaPieD_Derivada2da = Derivada_Vector(Angulos.BetaPieD_Derivada,fm);
Angulos.BetaPieI_Derivada2da = Derivada_Vector(Angulos.BetaPieI_Derivada,fm);

Angulos.GammaPieD_Derivada2da = Derivada_Vector(Angulos.GammaPieD_Derivada,fm);
Angulos.GammaPieI_Derivada2da = Derivada_Vector(Angulos.GammaPieI_Derivada,fm);


%% ................... Calculos Velocidades Angulares .....................

Matrices.Alfa_MusloD = zeros(3,3,length(Angulos.AlfaMusloD_Derivada));
Matrices.Beta_MusloD = zeros(3,3,length(Angulos.BetaMusloD_Derivada));
Matrices.Gamma_MusloD = zeros(3,3,length(Angulos.GammaMusloD_Derivada));

Matrices.Alfa_MusloI = zeros(3,3,length(Angulos.AlfaMusloI_Derivada));
Matrices.Beta_MusloI = zeros(3,3,length(Angulos.BetaMusloI_Derivada));
Matrices.Gamma_MusloI = zeros(3,3,length(Angulos.GammaMusloI_Derivada));

for i = 1:length(Angulos.AlfaMusloD_Derivada)
    
    %Alfa
    
    Matrices.Alfa_MusloD(1,1,i) = cosd(Angulos.AlfaMusloD(i));
    Matrices.Alfa_MusloD(2,2,i) = cosd(Angulos.AlfaMusloD(i));
    Matrices.Alfa_MusloD(1,2,i) = sind(Angulos.AlfaMusloD(i));
    Matrices.Alfa_MusloD(2,1,i) = - sind(Angulos.AlfaMusloD(i));
    Matrices.Alfa_MusloD(3,3,i) = 1;
    
    Matrices.Alfa_MusloI(1,1,i) = cosd(Angulos.AlfaMusloI(i));
    Matrices.Alfa_MusloI(2,2,i) = cosd(Angulos.AlfaMusloI(i));
    Matrices.Alfa_MusloI(1,2,i) = sind(Angulos.AlfaMusloI(i));
    Matrices.Alfa_MusloI(2,1,i) = - sind(Angulos.AlfaMusloI(i));
    Matrices.Alfa_MusloI(3,3,i) = 1;
    
    %Beta
    Matrices.Beta_MusloD(1,1,i) = 1;
    Matrices.Beta_MusloD(2,2,i) = cosd(Angulos.BetaMusloD(i));
    Matrices.Beta_MusloD(3,3,i) = cosd(Angulos.BetaMusloD(i));
    Matrices.Beta_MusloD(2,3,i) = sind(Angulos.BetaMusloD(i));
    Matrices.Beta_MusloD(3,2,i) = - sind(Angulos.BetaMusloD(i));
    
    Matrices.Beta_MusloI(1,1,i) = 1;
    Matrices.Beta_MusloI(2,2,i) = cosd(Angulos.BetaMusloI(i));
    Matrices.Beta_MusloI(3,3,i) = cosd(Angulos.BetaMusloI(i));
    Matrices.Beta_MusloI(2,3,i) = sind(Angulos.BetaMusloI(i));
    Matrices.Beta_MusloI(3,2,i) = - sind(Angulos.BetaMusloI(i));
    
    %Gamma
    
    Matrices.Gamma_MusloD(1,1,i) = cosd(Angulos.GammaMusloD(i));
    Matrices.Gamma_MusloD(2,2,i) = cosd(Angulos.GammaMusloD(i));
    Matrices.Gamma_MusloD(1,2,i) = - sind(Angulos.GammaMusloD(i));
    Matrices.Gamma_MusloD(2,1,i) = sind(Angulos.GammaMusloD(i));
    Matrices.Gamma_MusloD(3,3,i) = 1;
    
    Matrices.Gamma_MusloI(1,1,i) = cosd(Angulos.GammaMusloI(i));
    Matrices.Gamma_MusloI(2,2,i) = cosd(Angulos.GammaMusloI(i));
    Matrices.Gamma_MusloI(1,2,i) = sind(Angulos.GammaMusloI(i));
    Matrices.Gamma_MusloI(2,1,i) = - sind(Angulos.GammaMusloI(i));
    Matrices.Gamma_MusloI(3,3,i) = 1;
    
end

Cinematica.MusloD.V_angular = zeros(length(Angulos.AlfaMusloD_Derivada),3);

for i = 1:length(Angulos.AlfaMusloD_Derivada)
    
    VectorAlfa = [0 0 Angulos.AlfaMusloD_Derivada(i)];
    VectorBeta = [Angulos.BetaMusloD_Derivada(i) 0 0];
    VectorGamma = [0 0 Angulos.GammaMusloD_Derivada(i)];
    
    VectorAlfa = Matrices.Beta_MusloD(:,:,i) * (VectorAlfa');
    VectorAlfa = ( Matrices.Gamma_MusloD(:,:,i) * (VectorAlfa) )';
    
    VectorBeta = ( Matrices.Gamma_MusloD(:,:,i) *(VectorBeta') )';
    
    Cinematica.MusloD.V_angular(i,:) = VectorAlfa + VectorBeta + VectorGamma;
    
end

subplot(3,1,1);
plot(Cinematica.MusloD.V_angular(FrameRHS:FrameRHS2,1)); grid on;
subplot(3,1,2);
plot(Cinematica.MusloD.V_angular(FrameRHS:FrameRHS2,2)); grid on;
subplot(3,1,3);
plot(Cinematica.MusloD.V_angular(FrameRHS:FrameRHS2,3)); grid on; hold on;
plot(Cinematica.MusloD.V_angular(FrameRHS:FrameRHS2,3));
plot(Cinematica.MusloD.V_angular(FrameRHS:FrameRHS2,3));


%% .......................... GRAFICAS EULER

%................ Graficas Muslo

subplot(3,1,1);

plot(Angulos.AlfaMusloD(FrameRHS:FrameRHS2)); grid on; hold on;
plot(Angulos.AlfaMusloI(FrameLHS:FrameLHS2)); hold on;

subplot(3,1,2);
plot(Angulos.BetaMusloD(FrameRHS:FrameRHS2)); grid on; hold on;
plot(Angulos.BetaMusloI(FrameLHS:FrameLHS2)); hold on;

subplot(3,1,3);
plot(Angulos.GammaMusloD(FrameRHS:FrameRHS2)); grid on; hold on;
plot(Angulos.GammaMusloI(FrameLHS:FrameLHS2)); 


%% ................ Graficas Pierna

figure()
subplot(3,1,1);
plot(Angulos.AlfaPiernaD(FrameRHS:FrameRHS2)); grid on; hold on;
plot(Angulos.AlfaPiernaI(FrameLHS:FrameLHS2)); hold on;

subplot(3,1,2);
plot(Angulos.BetaPiernaD(FrameRHS:FrameRHS2)); grid on; hold on;
plot(Angulos.BetaPiernaI(FrameLHS:FrameLHS2)); hold on;

subplot(3,1,3);
plot(Angulos.GammaPiernaD(FrameRHS:FrameRHS2)); grid on; hold on;
plot(Angulos.GammaPiernaI(FrameLHS:FrameLHS2)); 

%% ................ Graficas Pie
figure()
subplot(3,1,1);
plot(Angulos.AlfaPieD(FrameRHS:FrameRHS2)); grid on; hold on;
plot(Angulos.AlfaPieI(FrameLHS:FrameLHS2)); hold on;

subplot(3,1,2);
plot(Angulos.BetaPieD(FrameRHS:FrameRHS2)); grid on; hold on;
plot(Angulos.BetaPieI(FrameLHS:FrameLHS2)); hold on;

subplot(3,1,3);
plot(Angulos.GammaPieD(FrameRHS:FrameRHS2)); grid on; hold on;
plot(Angulos.GammaPieI(FrameLHS:FrameLHS2));

%% .................. Calculo de Velocidades y Aceleraciones lineales

Cinematica.MusloD.V_lineal = Derivada_Vector(Puntos.CM.MusloD, fm);
Cinematica.MusloD.A_lineal = Derivada_Vector(Cinematica.MusloD.V_lineal, fm);

plot(Cinematica.MusloD.V_lineal(FrameRHS:FrameRHS2,1)); grid on; hold on;

plot(Cinematica.MusloD.A_lineal(FrameRHS:FrameRHS2,1)/5); grid on; hold on;








