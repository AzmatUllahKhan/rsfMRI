function downsampling(input,output,rate)
% input: input file directory
% output: output file directory
% rate: downsampling rate

%Loading scan of fMRI for subject
subject = niftiread(input);
volumes = subject.hdr.dime.dim(1,5); %Calculating total number of volumes in one session
down_volumes = volumes/rate;  %Calculating number of volumes after downsampling
subject.hdr.dime.dim(1,5) = down_volumes;   %Changing number of volumes to new number of volumes in the header file
subject.original.hdr.dime.dim(1,5) = down_volumes;  %Changing number of volumes to new number of volumes in the header file
downsampled = zeros(91,109,91,down_volumes);    %Creating a variable for downsampled data

for i = 1 : down_volumes
    j = i*8;
   downsampled(:,:,:,i) =  subject.img(:,:,:,j);
end

%Replacing and saving downsampled data for L-R data
subject = rmfield(subject,'img');
subject.img = downsampled;
niftiwrite(subject,output);

end