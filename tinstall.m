classdef tinstall < matlab.unittest.TestCase
    properties (TestParameter)
        % This is not the complete list of allow products, it is just a
        % small sample to smoke test license checkout.
        allowed = {'matlab', 'simulink', 'signal_toolbox', 'statistics_toolbox', ...
            'optimization_toolbox', 'symbolic_toolbox', 'image_toolbox', 'control_toolbox', ...
            'signal_blocks', 'curve_fitting_toolbox'}
        restricted = {'rtw_embedded_coder', 'filter_design_hdl_coder', 'gpu_coder', ...
            'simulink_hdl_coder', 'matlab_coder', 'real-time_workshop', 'simulink_plc_coder'}
        example = {'matlab/intro', 'optim/SolveAConstrainedNonlinearProblemProblemBasedExample', ...
            'curvefit/FitPolynomialExample', 'simulink_general/sldemo_bounceExample'}
    end
    
    methods (Test)
        function testCheckoutAllowedLicense(testCase, allowed)
            [status, msg] = license('checkout', allowed);
            testCase.assertTrue(logical(status), msg);
        end
        
        function testFailToCheckoutRestrictedLicense(testCase, restricted)
            status = license('checkout', restricted);
            testCase.assertFalse(logical(status), [restricted ' should not checkout']);
        end

        function testRootPath(testCase)
            release = version('-release');
            if ismac()
                expected = ['/Applications/MATLAB_R' release '.app'];
            elseif isunix()
                expected = ['/usr/local/MATLAB/R' release];
            elseif ispc()
                expected = ['C:\Program Files\MATLAB\R' release];
            end
            testCase.assertEqual(matlabroot(), expected)
        end
        
        function testRunExample(testCase, example)
            try
                meta = findExample(example);
                testCase.applyFixture(matlab.unittest.fixtures.PathFixture(meta.componentDir));
                run(fullfile(meta.componentDir, 'main', meta.main));
            catch e
                testCase.assertFail(e.message);
            end
        end
    end
end