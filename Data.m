classdef Data                 %Defining Class
    properties                %Variables used
        covidData
        Date
        Country
        Country_Index
        State
        State_Index
    end
    methods
        function obj = Data(in) %It stores design data, which have parameters and signals, and include data.
            load covid_data.mat covid_data  %replacing mat file to simple covid_data.
            obj.covidData = covid_data;
            obj.Country = covid_data(:,1);  %First column 
            obj.Date = covid_data(1,3:end); %First row 3rd column till the end
            obj.Country{1} = 'Global';      %to show data alltogether.
            [~,n] = ismember(obj.Country,in); %n is a variable (entering data of obj.country in in)
            [~,obj.Country_Index]= max(n); 
            obj.State_Index = obj.Country_Index:(obj.Country_Index+sum(n)-1);
            obj.State = covid_data(obj.State_Index,2);
            obj.State{1} = 'All';     %similar to global (data not there for state)
        end
        function obj = Cases_Vector(obj,inc)
            CasesV = zeros(1,length(obj.Date));
            for ii = 3:length(obj.Date)+2
                CasesV(ii-2) = obj.covidData{inc,ii}(1,1);
            end
            obj=CasesV;
        end
        function obj= Deaths_Vector(obj, ind)
DeathsV=zeros(1,length(obj.Date));
for ii=3: length (obj.Date)+2
    DeathsV(ii-2)=obj.covidData{ind, ii}(1,2);
end
obj = DeathsV;
end
function obj= global_Cases_And_Deaths(obj)
states=obj.covidData(:, 2);
All=zeros(1, length(states));
global_Cases=zeros(length(states), length(obj.Date));
global_Deaths =zeros(length(states), length(obj.Date));
for i=1:length(states)
    if isempty(states{i})
        All(i)=i;
    end
end
for ii=1:length(states)
if All(ii)==0
    continue;
else 
  for  jj=3:length(obj.Date)+2
    global_Cases(ii,jj-2)= obj.covidData{ii,jj}(1,1);
  end
   for k=3:length(obj.Date)+2
    global_Deaths(ii,k-2)= obj.covidData{ii,k}(1,2);
   end
end
end
obj=[sum(global_Cases); sum(global_Deaths)];
                
        end
    end
end