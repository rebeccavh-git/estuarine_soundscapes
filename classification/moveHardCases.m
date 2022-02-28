% script to read the missclassifications output and move files with a
% majority mis-classification to a new location.
%
% must be run on a unix system from exactly the right filesystem location

%foo=importdata('missclassifications.csv');
%foo=importdata('miss_classifications_15-Nov-2021.csv');
%foo=importdata('miss_classifications_2_2021-11-15-11-53.csv');

for i=1:numel(foo.data)
  if foo.data(i)>3
    mstring=['!mv test_specs',filesep,foo.textdata{i},' hard_specs',filesep,foo.textdata{i}];
    disp(mstring)
    eval(mstring)
  end
  disp('.')
end