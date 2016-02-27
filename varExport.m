function varExport(varargin)

n = nargin;

fid = fopen('exportFile','w+');
fwrite(fid,uint32(n),'uint32');

for i = 1:n
    fwrite(fid,uint32(size(varargin{i},1)),'uint32');
    fwrite(fid,uint32(size(varargin{i},2)),'uint32');
    fwrite(fid,varargin{i},'double');
end 

fclose(fid);

system('mv exportFile ~/Documents/Development/Python/exportFile');