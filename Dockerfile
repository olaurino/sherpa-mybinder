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

RUN conda install -n python3 -y -c sherpa \
  notebook=4.2.3 matplotlib astropy=1.3 scipy sherpa=4.8 nomkl && \
  conda remove -y --force qt pyqt qtconsole && \ 
  conda clean -tipsy && \
  rm -rf /opt/conda/pkgs/* && \
  pip install saba corner

# Expose the notebook port
EXPOSE 8888

# Add notebooks to image
ADD sherpa-notebooks/* /data/
ADD sherpa-notebooks/images/ /data/images/

# Set working dir
WORKDIR /data

# Mount conda environments folder as volume for persistence
VOLUME /opt/conda/envs

# Single CPU Configuration file
ENV SHERPARC=/data/sherparc

#****************************************************************************
# Fire it up
#****************************************************************************
CMD ipython notebook --no-browser --port 8888 --ip=*

