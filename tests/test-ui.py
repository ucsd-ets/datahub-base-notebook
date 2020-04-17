#!/usr/bin/python

"""To be used with docker compose"""

import selenium
from selenium.webdriver.chrome.options import Options
from selenium.webdriver import Chrome
from selenium.webdriver.support.ui import WebDriverWait as webdriverwait
import selenium.webdriver.support.expected_conditions as ec
from selenium.webdriver.common.by import By as by

import time, logging, copy, os

if __name__ == '__main__':
    # setup the logger
    logger = logging.getLogger('selenium_ui')
    logger.setLevel(logging.INFO)
    fh = logging.FileHandler('/opt/datahub-base-notebook/ui-test.log')
    fh.setLevel(logging.INFO)
    
    logger.addHandler(fh)
    
    # initialize the driver options and connect to the notebook
    options = Options()
    options.headless = True
    options.add_argument('--window-size=1920x1480')
    options.add_argument('--disable-gpu')
    options.add_argument('--disable-extensions')
    options.add_argument("--proxy-server='direct://'")
    options.add_argument('--proxy-bypass-list=*')
    options.add_argument('--start-maximized')
    options.add_argument("disable-infobars")
    options.add_argument('--ignore-ssl')
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-dev-shm-usage')

    browser = Chrome(options=options)
    
    time.sleep(60) # give it some time for nbconvert to run
    browser.get('http://jupyter:8888')
    logger.info('Connected to jupyter notebook')
    
    WAIT_TIME = 15

    # check only 1 tab
    assert len(browser.window_handles) == 1

    # check DSMLP cluster status '//*[@id="tabs"]/li[6]/a'
    cluster_status_link = webdriverwait(browser, WAIT_TIME).until(
        ec.presence_of_element_located((by.LINK_TEXT, 'DSMLP Cluster Status'))
    )
    cluster_status_link.click()
    logger.info('DSMLP cluster status ok')
    
    # check courses tab (nbgrader)
    courses_link = webdriverwait(browser, WAIT_TIME).until(
        ec.presence_of_element_located((by.LINK_TEXT, 'Courses'))
    )
    courses_link.click()
    logger.info('nbgrader ok')
    
    # navigate back to the files tab
    files_link = webdriverwait(browser, WAIT_TIME).until(
        ec.presence_of_element_located((by.LINK_TEXT, 'Files'))
    )
    files_link.click()
    
    # select the new button + create a python notebook
    new_button = webdriverwait(browser, WAIT_TIME).until(
        ec.element_to_be_clickable((by.ID, 'new-dropdown-button'))
    )
    new_button.click()
    
    create_py3_notebook = webdriverwait(browser, WAIT_TIME).until(
        ec.element_to_be_clickable((by.LINK_TEXT, 'Python 3'))
    )
    create_py3_notebook.click()
    
    time.sleep(2)
    
    # check new tab with py notebook
    assert len(browser.window_handles) == 2
    notebook = browser.window_handles[-1]
    browser.switch_to.window(notebook)
    
    # check nbresuse
    nbresuse_btn = webdriverwait(browser, WAIT_TIME).until(
        ec.element_to_be_clickable((by.XPATH, '//*[@id="collect_metrics"]'))
    )
    nbresuse_btn.click()
    logger.info('nbresuse ok')
    
    # select the quit button
    file = browser.window_handles[0]
    browser.switch_to.window(file)
    quit_btn = webdriverwait(browser, WAIT_TIME).until(
        ec.element_to_be_clickable((by.ID, 'shutdown'))
    )
    quit_btn.click()
    
    logger.info('UI testing all pass')
    