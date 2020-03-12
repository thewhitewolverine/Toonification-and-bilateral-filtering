function varargout = blind(varargin)
% BLIND MATLAB code for blind.fig
%      BLIND, by itself, creates a new BLIND or raises the existing
%      singleton*.
%
%      H = BLIND returns the handle to a new BLIND or the handle to
%      the existing singleton*.
%
%      BLIND('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BLIND.M with the given input arguments.
%
%      BLIND('Property','Value',...) creates a new BLIND or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before blind_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to blind_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help blind

% Last Modified by GUIDE v2.5 19-Oct-2018 19:24:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @blind_OpeningFcn, ...
                   'gui_OutputFcn',  @blind_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before blind is made visible.
function blind_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to blind (see VARARGIN)

% Choose default command line output for blind
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes blind wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = blind_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in load.
function load_Callback(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im imgray ft M N g blur x y i mmax
[path, user_cance]=imgetfile();                            
if user_cance
    magbox(sprintf('Error'),'Error','Error');
    return
end
im=im2double(imread(path));    
imgray=rgb2gray(im);
[M,N]=size(imgray);
i=0;
ft=fftshift(fft2(imgray));
g=fspecial('gaussian', [11 11],3);
blur=zeros(M,N);

x=floor(M/2);
y=floor(N/2);
blur(x-5:x+5,y-5:y+5)=g;
axes(handles.axes1);
imshow(im,[]);
axes(handles.axes2);
imshow(blur,[]);
    bf1=fftshift(fft2(blur,M,N));
    res1=ft./((abs(bf1)<4)*(4) + bf1);
    res11=ifft2(ifftshift(res1));
    Ms1 = sum(sum((res11-imgray.^2)))/(M*N);
    Ps1 = 10*log10(256*256/Ms1); 
mmax=Ps1;

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)                      
global imgray ft M N g blur x y i mmax
    
    for i=1:500
        
    blur1=blur;
    %==========================================
    x1=x+5;
    y1=y;
    blur1(x1-5:x1+5,y1-5:y1+5)=g;
    bf1=fftshift(fft2(blur1,M,N));
    res1=ft./((abs(bf1)<4)*(4) + bf1);
    res11=ifft2(ifftshift(res1));
    Ms1 = sum(sum((res11-imgray.^2)))/(M*N);
    Ps1 = 10*log10(256*256/Ms1); 
    %==========================================
    blur2=blur;
    x2=x;
    y2=y+5;
    blur2(x2-5:x+5,y2-5:y2+5)=g;
    bf2=fftshift(fft2(blur2,M,N));
    res2=ft./((abs(bf2)<4)*(4) + bf2);
    res21=ifft2(ifftshift(res2));
    Ms2 = sum(sum((res21-imgray.^2)))/(M*N);
    Ps2 = 10*log10(256*256/Ms2); 

    %==========================================
    blur3=blur;
    x3=x+5;
    y3=y+5;
    blur3(x3-5:x3+5,y3-5:y3+5)=g;
    bf3=fftshift(fft2(blur3,M,N));
    res3=ft./((abs(bf3)<4)*(4) + bf3);
    res31=ifft2(ifftshift(res3));
    Ms3 = sum(sum((res31-imgray.^2)))/(M*N);
    Ps3 = 10*log10(256*256/Ms3); 
    %==========================================
    blur4=blur;
    x4=x-5;
    y4=y+5;
    blur4(x4-5:x4+5,y4-5:y4+5)=g;
    bf4=fftshift(fft2(blur4,M,N));
    res4=ft./((abs(bf4)<4)*(4) + bf4);
    res41=ifft2(ifftshift(res4));
    Ms4 = sum(sum((res41-imgray.^2)))/(M*N);
    Ps4 = 10*log10(256*256/Ms4); 
    %==========================================
    blur5=blur;
    x5=x-5;
    y5=y;
    blur5(x5-5:x5+5,y5-5:y5+5)=g;
    bf5=fftshift(fft2(blur5,M,N));
    res5=ft./((abs(bf5)<4)*(4) + bf5);
    res51=ifft2(ifftshift(res5));
    Ms5 = sum(sum((res51-imgray.^2)))/(M*N);
    Ps5 = 10*log10(256*256/Ms5); 
    %==========================================
    blur6=blur;
    x6=x-5;
    y6=y-5;
    blur6(x6-5:x6+5,y6-5:y6+5)=g;
    bf6=fftshift(fft2(blur6,M,N));
    res6=ft./((abs(bf6)<4)*(4) + bf6);
    res61=ifft2(ifftshift(res6));
    Ms6 = sum(sum((res61-imgray.^2)))/(M*N);
    Ps6 = 10*log10(256*256/Ms6); 
    %==========================================
    blur7=blur;
    x7=x;
    y7=y-5;
    blur7(x7-5:x7+5,y7-5:y7+5)=g;
    bf7=fftshift(fft2(blur7,M,N));
    res7=ft./((abs(bf7)<4)*(4) + bf7);
    res71=ifft2(ifftshift(res7));
    Ms7 = sum(sum((res71-imgray.^2)))/(M*N);
    Ps7 = 10*log10(256*256/Ms7); 
    %==========================================
    blur8=blur;
    x8=x+5;
    y8=y-5;
    blur8(x8-5:x8+5,y8-5:y8+5)=g;
    bf8=fftshift(fft2(blur8,M,N));
    res8=ft./((abs(bf8)<4)*(4) + bf8);
    res81=ifft2(ifftshift(res8));
     Ms8 = sum(sum((res81-imgray.^2)))/(M*N);
    Ps8 = 10*log10(256*256/Ms8); 
    %==========================================
    ps=[Ps1 Ps2 Ps3 Ps4 Ps5 Ps6 Ps7 Ps8];
    xm=[x1 x2 x3 x4 x5 x6 x7 x8];
    ym=[y1 y2 y3 y4 y5 y6 y7 y8];
    number=1;
    for j=1:8
        if(abs(ps(j))>=abs(mmax))
            number=number+1;
            disp(j);
            blur(xm(j)-5:xm(j)+5,ym(j)-5:ym(j)+5)=g;
            x=x+xm(j);
            y=y+ym(j);
        end
    end
    x=ceil(x/number);
    y=ceil(y/number);
    
    if(number==1)
         if (Ps1==mmax)
         disp('right.');
         blur=blur1;
         disp('1');
         
         axes(handles.axes1);
         imshow(log(1+abs(res11)),[]);
         axes(handles.axes2);
         imshow(blur,[]);
         x=x1;
         y=y1;
     elseif (Ps2 == mmax)
         disp('down.');
         disp('2');
         blur=blur2;
           
         axes(handles.axes1);
         imshow(log(1+abs(res21)),[]);
         axes(handles.axes2);
         imshow(blur,[]);
         x=x2;
         y=y2;
     elseif (Ps3 == mmax)
         disp('diagonal.');
         disp('3');
         blur=blur3;
         
         axes(handles.axes1);
         imshow(log(1+abs(res31)),[]);
         axes(handles.axes2);
         imshow(blur,[]);
         x=x3;
         y=y3;
     elseif (Ps4 == mmax)
         disp('diagonal.');
         disp('4');
         blur=blur4;
         
         axes(handles.axes1);
         imshow(log(1+abs(res41)),[]);
         axes(handles.axes2);
         imshow(blur,[]);
         x=x4;
         y=y4;
     elseif (Ps5 == mmax)
         disp('diagonal.');
         disp('5');
         blur=blur5;
         
         axes(handles.axes1);
         imshow(log(1+abs(res51)),[]);
         axes(handles.axes2);
         imshow(blur,[]);
         x=x5;
         y=y5;
     elseif (Ps6 == mmax)
         disp('diagonal.');
         disp('6');
         blur=blur6;
         
         axes(handles.axes1);
         imshow(log(1+abs(res61)),[]);
         axes(handles.axes2);
         imshow(blur,[]);
         x=x6;
         y=y6;
     elseif (Ps7 == mmax)
         disp('diagonal.');
         disp('7');
         blur=blur7;
         
         axes(handles.axes1);
         imshow(log(1+abs(res71)),[]);
         axes(handles.axes2);
         imshow(blur,[]);
         x=x7;
         y=y7;
     else
         disp('diagonal.');
         disp('8');
         blur=blur8;
         
         axes(handles.axes1);
         imshow(log(1+abs(res81)),[]);
         axes(handles.axes2);
         imshow(blur,[]);
         x=x8;
         y=y8;
     end 
        
   end
    
    bf9=fftshift(fft2(blur,M,N));
    res9=ft./((abs(bf9)<4)*(4) + bf9);
    res91=ifft2(ifftshift(res9));
    Ms9 = sum(sum((res91-imgray.^2)))/(M*N);
    Ps9 = 10*log10(256*256/Ms9); 
    axes(handles.axes1);
    imshow(log(1+abs(res91)),[]);
    axes(handles.axes2);
    imshow(blur,[]); 
    mmax=abs(Ps9);
    end
    




