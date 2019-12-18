import {utils} from "@xeokit/xeokit-sdk/src/viewer/scene/utils"
/**
 * Default server client which loads content via HTTP from the file system.
 */
class XeokitServer {

  /**
   *
   * @param cfg
   * @param.cfg.dataDir Base directory for content.
   */
  constructor(cfg = {}) {
    this._dataDir = cfg.dataDir || "";
  }

  /**
   * Gets the manifest of all projects.
   * @param done
   * @param error
   */
  getProjects(done, _error) {
    done(window.gon.ifc_models.projects);
  }

  /**
   * Gets a manifest for a project.
   * @param projectId
   * @param done
   * @param error
   */
  getProject(_projectId, done, _error) {
    done({ models: window.gon.ifc_models.models });
  }

  /**
   * Gets metadata for a model within a project.
   * @param projectId
   * @param modelId
   * @param done
   * @param error
   */
  getMetadata(_projectId, modelId, done, error) {
    let attachmentId = window.gon.ifc_models.metadata_attachment_ids[modelId];
    const url = "/attachments/" + attachmentId + "/content";
    console.log("Loading model metadata: " + url);
    utils.loadJSON(url, done, error);
  }

  /**
   * Gets geometry for a model within a project.
   * @param projectId
   * @param modelId
   * @param done
   * @param error
   */
  getGeometry(projectId, modelId, done, error) {
    let attachmentId = window.gon.ifc_models.xkt_attachment_ids[modelId];
    const url = "/attachments/" + attachmentId + "/content";
    console.log("Loading model geometry: " + url);
    utils.loadArraybuffer(url, done, error);
  }
}

export {XeokitServer};