function W = fcnGetW; 

w = [   0
        0
        0
        2
        1
        0
        0
        2
        15
        6
        15
        15
        0
        0
        0
        0
        0
        0
        0
        1
        1
        4
        4
        2
        4
        15
        0
        0
        15]; 
W = ones(32,1)*(w'); 

%  0   {'Posterior dominant rhythm (PDR)'                                      }
%  0   {'Background alpha activity'                                            }
%  0   {'Background beta activity (excluding sleep spindles)'                  }
%  2   {'Generalized irregular delta activity'                                 }
%  1   {'Generalized irregular theta activity'                                 }
%  0   {'Focal irregular delta activity'                                       }
%  0   {'Focal irregular theta activity'                                       }
% 8 2   {'Attenuation/low voltage (10-20 uV)'                                   }
%  15   {'Suppression/very low voltage (<10 uV)'                                }
% 10->  6  {'Generalized brief attenuations'                                       }
% 11->  15 {'Burst suppression with epileptiform activity'                         }
% 12->15    {'Burst suppression without epileptiform activity'                      }
%   0  {'Eye blinks'                                                           }
%   0  {'Sleep spindles'                                                       }
%   0  {'K-complexes'                                                          }
%   0  {'Vertex waves'                                                         }
%   0 {'Generalized IEDs'                                                     }
%   0  {'Focal IEDs'                                                           }
%  19 0  {'Multifocal IEDs'                                                      }
%   1  {'Generalized rhythmic delta activity (GRDA)'                           }
%   1  {'Lateralized rhythmic delta activity (LRDA)'                           }
%   4  {'Generalized periodic discharges (GPDs) without a triphasic morphology'}
%   4  {'Generalized periodic discharges (GPDs) with a triphasic morphology'   }
%   2  {'Lateralized periodic discharges (LPDs)'                               }
%   4  {'Bilateral independent periodic discharges (BIPDs)'                    }
%   15  {'Extreme delta brush (EDB)'                                            }
%   0  {'Brief potentially ictal rhythmic discharges (BIRDs)'                  }
%   0  {'Focal seizure'                                                        }
%   15  {'Generalized seizure'                                                  }
%   0  {'Posterior dominant rhythm (PDR)'                                      }
%   0 {'Background alpha activity'                                            }