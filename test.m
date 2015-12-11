% Match all images
% Results in vector T where column 1 is for resulted id,
% Column 2 is the "threshold"
% colmn 3 is the image index.
% Goes through images in order: DB0, DB1, DB2 with 0, 0, 0 in between to
% mark the start of a new database or between bl, cl, ex, il
% If the image failed to run, it will be marked with -1, -1, index

warning('off','all')
clear
%Loop through DB0
im = imread('DB0/db0_2.jpg');
try
    [T(1,1), T(1,2)] = tnm034( im );
    T(1,3) = 3;
catch
    T(1,1) = -1;
    T(1,2) = -1;
    T(1,3) = 2;
end
im = imread('DB0/db0_3.jpg');
try
    [T(end+1,1), T(end,2)] = tnm034( im );
    T(end,3) = 3;
catch
    T(end+1,1) = -1;
    T(end,2) = -1;
    T(end,3) = 3;
end
im = imread('DB0/db0_4.jpg');
try
    [T(end+1,1), T(end,2)] = tnm034( im );
    T(end,3) = 4;
catch
    T(end+1,1) = -1;
    T(end,2) = -1;
    T(end,3) = 4;
end

T(end+1,1) = 0;
T(end,2) = 0;

%Loop through DB1
for i = 1:16
    if i < 10
        im = imread(sprintf('DB1/db1_0%d.jpg', i));
        try
            [T(end+1,1), T(end,2)] = tnm034( im );
            T(end,3) = i;
        catch
            T(end+1,1) = -1;
            T(end,2) = -1;
            T(end,3) = i;
        end
    else
        try
            im = imread(sprintf('DB1/db1_%d.jpg', i));
            [T(end+1,1), T(end,2)] = tnm034( im );
            T(end,3) = i;
        catch
            T(end+1,1) = -1;
            T(end,2) = -1;
            T(end,3) = i;
        end
    end
end
%%
%Loop through DB2
T(end+1,1) = 0;
T(end,2) = 0;
%bl
for i = 1:14
    if i < 8
        if i == 3
            %ignore
        else
            try
            im = imread(sprintf('DB2/bl_0%d.jpg', i));
            [T(end+1,1), T(end,2)] = tnm034( im );
            T(end,3) = i;
            catch
                T(end+1,1) = -1;
                T(end,2) = -1;
                T(end,3) = i;
            end
        end
    end
    if i == 10
        try
        im = imread(sprintf('DB2/bl_%d.jpg', i));
        [T(end+1,1), T(end,2)] = tnm034( im );
        T(end,3) = i;
        catch
            T(end+1,1) = -1;
                T(end,2) = -1;
                T(end,3) = i;
        end
    end
    if i == 13
        try
        im = imread(sprintf('DB2/bl_%d.jpg', i));
        [T(end+1,1), T(end,2)] = tnm034( im );
        T(end,3) = i;
        catch
            T(end+1,1) = -1;
                T(end,2) = -1;
                T(end,3) = i;
        end
    end
    if i == 14
        try
        im = imread(sprintf('DB2/bl_%d.jpg', i));
        [T(end+1,1), T(end,2)] = tnm034( im );
        T(end,3) = i;
        catch
            T(end+1,1) = -1;
                T(end,2) = -1;
                T(end,3) = i;
        end
    end
end
T(end+1,1) = 0;
T(end,2) = 0;
% cl
for i = 1:16
    if (i < 10)
        try
        im = imread(sprintf('DB2/cl_0%d.jpg', i));
        [T(end+1,1), T(end,2)] = tnm034( im );
        T(end,3) = i;
        catch
            T(end+1,1) = -1;
                T(end,2) = -1;
                T(end,3) = i;
        end
    else
        try
        im = imread(sprintf('DB2/cl_%d.jpg', i));
        [T(end+1,1), T(end,2)] = tnm034( im );
        T(end,3) = i;
        catch
            T(end+1,1) = -1;
                T(end,2) = -1;
                T(end,3) = i;
        end
    end
end
T(end+1,1) = 0;
T(end,2) = 0;
%ex
try
im = imread('DB2/ex_01.jpg');
[T(end+1,1), T(end,2)] = tnm034( im );
T(end,3) = 1;
catch
    T(end+1,1) = -1;
    T(end,2) = -1;
    T(end,3) = 1;
end

try
im = imread('DB2/ex_03.jpg');
[T(end+1,1), T(end,2)] = tnm034( im );
T(end,3) = 3;
catch
T(end+1,1) = -1;
T(end,2) = -1;
T(end,3) = 3; 
end

try
im = imread('DB2/ex_04.jpg');
[T(end+1,1), T(end,2)] = tnm034( im );
T(end,3) = 4;
catch
T(end+1,1) = -1;
T(end,2) = -1;
T(end,3) = 4;    
end

try
im = imread('DB2/ex_07.jpg');
[T(end+1,1), T(end,2)] = tnm034( im );
T(end,3) = 7;
catch
T(end+1,1) = -1;
T(end,2) = -1;
T(end,3) = 7;    
end
try
im = imread('DB2/ex_09.jpg');
[T(end+1,1), T(end,2)] = tnm034( im );
T(end,3) = 9;
catch
T(end+1,1) = -1;
T(end,2) = -1;
T(end,3) = 9;    
end

try
im = imread('DB2/ex_11.jpg');
[T(end+1,1), T(end,2)] = tnm034( im );
T(end,3) = 11;
catch
T(end+1,1) = -1;
T(end,2) = -1;
T(end,3) = 11;
end

try
im = imread('DB2/ex_12.jpg');
[T(end+1,1), T(end,2)] = tnm034( im );
T(end,3) = 12;
catch
    T(end+1,1) = -1;
T(end,2) = -1;
T(end,3) = 12;
end

%il
T(end+1,1) = 0;
T(end,2) = 0;

try
im = imread('DB2/il_01.jpg');
[T(end+1,1), T(end,2)] = tnm034( im );
T(end,3) = 1;
catch
    T(end+1,1) = -1;
T(end,2) = -1;
T(end,3) = 1;
end

try
im = imread('DB2/il_07.jpg');
[T(end+1,1), T(end,2)] = tnm034( im );
T(end,3) = 7;
catch
    T(end+1,1) = -1;
T(end,2) = -1;
T(end,3) = 7;
end

try
im = imread('DB2/il_08.jpg');
[T(end+1,1), T(end,2)] = tnm034( im );
T(end,3) = 8;
catch
    T(end+1,1) = -1;
T(end,2) = -1;
T(end,3) = 8;
end

try
im = imread('DB2/il_09.jpg');
[T(end+1,1), T(end,2)] = tnm034( im );
T(end,3) = 9;
catch
    T(end+1,1) = -1;
T(end,2) = -1;
T(end,3) = 9;
end

try
im = imread('DB2/il_12.jpg');
[T(end+1,1), T(end,2)] = tnm034( im );
T(end,3) = 12;
catch
    T(end+1,1) = -1;
T(end,2) = -1;
T(end,3) = 12;
end

try
im = imread('DB2/il_16.jpg');
[T(end+1,1), T(end,2)] = tnm034( im );
T(end,3) = 16;
catch
    T(end+1,1) = -1;
T(end,2) = -1;
T(end,3) = 16;
end