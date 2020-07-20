import os
from unittest import TestCase

from jupyter_client.kernelspec import KernelSpecManager, NoSuchKernel, NATIVE_KERNEL_NAME
from jupyter_client import KernelManager

import pytest

from IPython.utils.capture import capture_output

TIMEOUT=60

class TestKernelNative(TestCase):
    def setUp(self):
        try:
            KernelSpecManager().get_kernel_spec(NATIVE_KERNEL_NAME)
        except NoSuchKernel:
            pytest.skip()

        self.km = KernelManager(kernel_name=NATIVE_KERNEL_NAME)
        self.km.start_kernel()
        self.kc = self.km.client()
        self.kc.start_channels()
        self.addCleanup(self.kc.stop_channels)
        self.addCleanup(self.km.shutdown_kernel)

    def test_1_execute(self):
        kc = self.kc

        with capture_output() as io:
            reply = kc.execute_interactive("print('hello')", timeout=TIMEOUT)
        assert 'hello' in io.stdout
        assert reply['content']['status'] == 'ok'
    
    def test_2_install(self):
        kc = self.kc

        with capture_output() as io:
            reply = kc.execute_interactive("!pip install multiprocess", timeout=TIMEOUT)
        assert 'Successfully installed' in io.stdout
        assert reply['content']['status'] == 'ok'

        with capture_output() as io:
            reply = kc.execute_interactive("import multiprocess", timeout=TIMEOUT)
        assert '' == io.stderr
        assert reply['content']['status'] == 'ok'


class TestKernelClean(TestCase):
    def setUp(self):
        try:
            KernelSpecManager().get_kernel_spec('python3_clean')
        except NoSuchKernel:
            pytest.skip()

        self.km = KernelManager(kernel_name='python3_clean')
        self.km.start_kernel()
        self.kc = self.km.client()
        self.kc.start_channels()
        self.addCleanup(self.kc.stop_channels)
        self.addCleanup(self.km.shutdown_kernel)

    def test_package(self):
        kc = self.kc

        with capture_output() as io:
            reply = kc.execute_interactive("import multiprocess", timeout=TIMEOUT)

        assert '' == io.stderr and '' == io.stdout
        assert reply['content']['status'] == 'ok'
