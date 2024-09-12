import subprocess  # import subprocess module

def update_notebook():  # initialize update_notebook() function

    file_path = './metadata/ipynb/input_img_id.ipynb'

    try:
        # Run the Jupyter notebook in place, re-running all cells
        subprocess.run(  # execute shell command for subprocess
            ['jupyter', 'nbconvert', '--to', 'notebook', '--inplace', '--execute', file_path],  # convert to jupyter notebook by overwriting cells in same file from start to finish
                       check=True)  # raise exception if subprocess fails
    except subprocess.CalledProcessError as e:  # handle subprocess fail
        print(f'Error {e}: Failed to update notebook.')
    except Exception as e:  # handle other errors
        print(f'Unexpected error {e} occurred.')

if __name__ == '__main__':  # call update_notebook() function only if script is run directly
    update_notebook()
