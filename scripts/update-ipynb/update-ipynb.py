import subprocess

def update_notebook():
    notebook_path = './metadata/ipynb/output_doc_id.ipynb'

    try:
        # Run the Jupyter notebook in place, re-running all cells
        result = subprocess.run(
            ['jupyter', 'nbconvert', '--to', 'notebook', '--inplace', '--execute', notebook_path],
            check=True,
            capture_output=True,
            text=True
        )
        print(f"Notebook '{notebook_path}' has been successfully updated.")
        print(f"STDOUT: {result.stdout}")
        print(f"STDERR: {result.stderr}")
    except subprocess.CalledProcessError as e:
        print(f"Error: Failed to update the notebook. {e}")
        print(f"STDOUT: {e.stdout}")
        print(f"STDERR: {e.stderr}")
    except Exception as e:
        print(f"Unexpected error occurred: {e}")

if __name__ == "__main__":
    update_notebook()
