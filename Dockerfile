#****************************************************************************
# A Sherpa Dockerfile. From an example by Andrew Odewahn (@odewahn)
#
#  - https://github.com/DougBurke/sherpa-standalone-notebooks
#  - https://github.com/sherpa/sherpa
#  - https://hub.docker.com/r/continuumio/miniconda/
#
#****************************************************************************
FROM andrewosh/binder-base:latest

MAINTAINER Omar Laurino <olaurino@cfa.harvard.edu>

#****************************************************************************
# Install required conda libraries
#****************************************************************************

RUN source activate python3 && \
  conda install -y -c sherpa \
  notebook=4.2.3 matplotlib astropy=1.3 scipy sherpa=4.8 nomkl && \
  conda remove -y --force qt pyqt qtconsole && \ 
  conda clean -tipsy && \
  rm -rf /opt/conda/pkgs/* && \
  pip install saba corner

RUN source activate root && \
  conda install -y -c sherpa \
  notebook=4.2.3 matplotlib astropy=1.3 scipy sherpa=4.8 nomkl && \
  conda remove -y --force qt pyqt qtconsole && \ 
  conda clean -tipsy && \
  rm -rf /opt/conda/pkgs/* && \
  pip install saba corner

# Add notebooks to image
RUN mv $HOME/notebooks/sherpa-notebooks/*.ipynb $HOME/notebooks && \
  mv $HOME/notebooks/sherparc $HOME/notebooks
  mv $HOME/notebooks/sherpa-notebooks/images $HOME/notebooks && \
  rm -rf $HOME/notebooks/sherpa-notebooks

# Single CPU Configuration file
ENV SHERPARC=$HOME/notebooks/sherparc

