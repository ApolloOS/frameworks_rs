'''Module that contains the test TestSourceStep.'''

from __future__ import absolute_import

import os
from harness.test_base_remote import TestBaseRemote
from harness.decorators import (
    ordered_test,
    cpp_only_test,
)


class TestSourceStep(TestBaseRemote):
    '''Test stepping through the source using step-in, -over and -out.'''

    bundle_target = {
        'java': 'BranchingFunCalls',
        'jni': 'JNIBranchingFunCalls',
        'cpp': 'CppBranchingFunCalls'

    }

    def script_dir(self):
        file_dir = os.path.dirname(os.path.realpath(__file__))
        app_root = os.path.join(file_dir, '..', '..')

        return {
            'java': os.path.join(app_root, 'java', 'BranchingFunCalls', 'src', 'rs'),
            'cpp': os.path.join(app_root, 'cpp', 'BranchingFunCalls'),
            'jni': os.path.join(app_root, 'jni', 'BranchingFunCalls', 'jnibranchingfuncalls')
        }[self.app_type]

    def setup(self, android):
        '''This test requires to be run on one thread.'''
        android.push_prop('debug.rs.max-threads', 1)

    def teardown(self, android):
        '''Reset the number of RS threads to the previous value.'''
        android.pop_prop('debug.rs.max-threads')

    def test_source_thread_step_in_out(self):
        self.try_command('language renderscript status',
                         ['Runtime Library discovered',
                          'Runtime Driver discovered'])

        self.try_command('b -f scalars.rs -l 47',
                         ['(pending)'])

        self.try_command('process continue',
                         ['stopped',
                          'stop reason = breakpoint',
                          'scalars.rs:47'])

        # set the source mapping
        self.set_src_map('scalars.rs', self.script_dir())

        self.try_command('process status',
                         ['-> 47',
                          'int i = in;'])

        #47     int i = in;
        self.try_command('thread step-in',
                         ['-> 48'])
        #48     float f = (float) i;
        self.try_command('thread step-in',
                         ['-> 49'])
        #49     modify_f(&f);
        self.try_command('thread step-over',
                         ['-> 50'])
        #50  	modify_i(&i);
        self.try_command('thread step-in',
                         ['-> 33'])
        #33         int j = *i;
        self.try_command('b -f scalars.rs -l 38',
                         ['librs.scalars.so`modify_i',
                          'scalars.rs:38'])
        self.try_command('c',
                         ['stop reason = breakpoint',
                          'scalars.rs:38',
                          '-> 38'])
        #38    set_i(i, 0);
        # For the line number anything between #20 and #22 is fine
        self.try_command('thread step-in',
                         [],
                         [r'-> 2[012]'])
        #22    int tmp = b;
        self.try_command('thread step-out',
                         ['-> 38'])

    @cpp_only_test()
    @ordered_test('last')
    def test_cpp_cleanup(self):
        self.try_command('breakpoint delete 1', ['1 breakpoints deleted'])

        self.try_command('breakpoint delete 2', ['1 breakpoints deleted'])

        self.try_command('process continue',
                         ['exited with status = 0'])
